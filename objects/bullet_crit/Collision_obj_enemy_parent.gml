// Проверяем инициализацию переменной (на всякий случай)
if (!variable_instance_exists(id, "cur_bounce_count")) {
    cur_bounce_count = 0;
}

if (random(1) < bounce_chance) {
    show_debug_message("баунс"); // исправлена опечатка
    
    // Ищем ближайшего врага в радиусе 100 пикселей
    var nearest_enemy = noone;
    var shortest_distance = 1000000;
    
    with (obj_enemy_parent) {
        if (instance_exists(id)) {
            var dist = point_distance(other.x, other.y, x, y);
            // Проверяем, что враг в радиусе 100 пикселей
            if (dist <= 100 && dist < shortest_distance) {
                shortest_distance = dist;
                nearest_enemy = id;
            }
        }
    }
    
    // Если нашли врага в радиусе, устанавливаем его как цель
    if (instance_exists(nearest_enemy)) {
        target = nearest_enemy;
        
        // Перенаправляем пулю к новому врагу
        direction = point_direction(x, y, target.x, target.y);
        image_angle = direction;
        speed = 6;
        
        cur_bounce_count += 1;
    } else {
        // Если врага в радиусе нет, уничтожаем пулю
        lifetime -= 10;
    }
} else {
    lifetime -= 10;
}

// Проверяем максимальное количество отскоков
if (cur_bounce_count >= global.bounce_shot_count) {
    lifetime -= 10;
}