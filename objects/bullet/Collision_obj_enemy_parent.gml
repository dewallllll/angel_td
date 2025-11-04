// Защита от неинициализированных переменных
if (!variable_instance_exists(id, "cur_bounce_count")) cur_bounce_count = 0;
if (!variable_instance_exists(id, "bounce_chance")) bounce_chance = global.bounce_shot_chance;
if (!variable_instance_exists(id, "damage_cooldown")) damage_cooldown = 0;
if (!variable_instance_exists(id, "can_damage")) can_damage = true;
if (!variable_instance_exists(id, "hit_enemies")) hit_enemies = [];

// Получаем ID текущего врага
var current_enemy = other.id;

// Проверяем, можно ли наносить урон и не был ли уже поражен этот враг
var already_hit = false;
for (var i = 0; i < array_length(hit_enemies); i++) {
    if (hit_enemies[i] == current_enemy) {
        already_hit = true;
        break;
    }
}

// Если можем наносить урон и враг еще не был поражен
if (can_damage && !already_hit) {
    // Наносим урон врагу (замените your_damage_value на ваше значение урона)
    // other.hp -= your_damage_value;
    
    // Добавляем врага в список пораженных
    array_push(hit_enemies, current_enemy);
    
    // Устанавливаем кулдаун урона
    damage_cooldown = damage_cooldown_max;
    can_damage = false; // Запрещаем нанесение урона до истечения кулдауна
    
    show_debug_message("Нанесен урон врагу");
}

// Проверяем шанс отскока
if (random(1) < bounce_chance) {
    show_debug_message("баунс");
    
    // Ищем ближайшего врага в радиусе 100 пикселей, исключая всех пораженных
    var nearest_enemy = noone;
    var shortest_distance = 1000000;
    
    with (obj_enemy_parent) {
        if (instance_exists(id)) {
            // Проверяем, не был ли этот враг уже поражен
            var is_hit = false;
            for (var i = 0; i < array_length(other.hit_enemies); i++) {
                if (other.hit_enemies[i] == id) {
                    is_hit = true;
                    break;
                }
            }
            
            // Если враг не был поражен, проверяем расстояние
            if (!is_hit) {
                var dist = point_distance(other.x, other.y, x, y);
                // Проверяем, что враг в радиусе 100 пикселей
                if (dist <= 100 && dist < shortest_distance) {
                    shortest_distance = dist;
                    nearest_enemy = id;
                }
            }
        }
    }
    
    // Если не нашли врага в радиусе 100, ищем любого непораженного врага
    if (!instance_exists(nearest_enemy)) {
        with (obj_enemy_parent) {
            if (instance_exists(id)) {
                var is_hit = false;
                for (var i = 0; i < array_length(other.hit_enemies); i++) {
                    if (other.hit_enemies[i] == id) {
                        is_hit = true;
                        break;
                    }
                }
                
                if (!is_hit) {
                    var dist = point_distance(other.x, other.y, x, y);
                    if (dist < shortest_distance) {
                        shortest_distance = dist;
                        nearest_enemy = id;
                    }
                }
            }
        }
    }
    
    // Если нашли врага, устанавливаем его как цель
    if (instance_exists(nearest_enemy)) {
        target = nearest_enemy;
        
        // Телепортируем пулю в сторону нового врага (с учетом спрайта 64x64)
        var teleport_distance = 70; // Расстояние телепортации (больше размера спрайта)
        var dir = point_direction(x, y, target.x, target.y);
        x += lengthdir_x(teleport_distance, dir);
        y += lengthdir_y(teleport_distance, dir);
        
        // Перенаправляем пулю к новому врагу
        direction = point_direction(x, y, target.x, target.y);
        image_angle = direction;
        speed = 6;
        
        cur_bounce_count += 1;
        show_debug_message("Отскок " + string(cur_bounce_count) + " к новому врагу");
    } else {
        // Если врага нет, уничтожаем пулю
        lifetime = 0;
        show_debug_message("Нет новых врагов для отскока");
    }
} else {
    // Если отскок не произошел, уничтожаем пулю
    lifetime = 0;
}

// Проверяем максимальное количество отскоков
if (cur_bounce_count >= global.bounce_shot_count) {
    lifetime = 0;
    show_debug_message("Максимум отскоков достигнут");
}