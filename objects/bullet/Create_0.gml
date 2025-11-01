//шанс отскока
bounce_chance = 0; // Значение по умолчанию
// Флаг для определения мультишот пуль
is_multishot = false;
hit_enemies = []
damage_cooldown = 0;
damage_cooldown_max = 10;
// Находим ближайшего врага
target = instance_nearest(x, y, obj_enemy_parent);
can_damage = true;
// Если враг найден, рассчитываем направление и задаем скорость
if (instance_exists(target))
{
    direction = point_direction(x, y, target.x, target.y);
    image_angle = direction;
    speed = 6;
}
else 
{
    instance_destroy();
}

// Логика мультишота ТОЛЬКО для обычных пуль (не мультишот)
if (!is_multishot && global.multishot_count > 0) 
{
    // Создаем массив для хранения всех выбранных целей
    selected_targets = [target];
    
    // Находим дополнительные цели для мультишот пуль
    for (var i = 0; i < global.multishot_count; i++) 
    {
        // Находим нового врага, которого еще не выбрали
        var new_target = noone;
        var shortest_distance = 1000000;
        
        // Перебираем всех врагов чтобы найти ближайшего невыбранного
        with (obj_enemy) 
        {
            if (instance_exists(id))
            {
                // Проверяем, не выбран ли уже этот враг
                var already_chosen = false;
                for (var j = 0; j < array_length(other.selected_targets); j++) 
                {
                    if (other.selected_targets[j] == id) 
                    {
                        already_chosen = true;
                        break;
                    }
                }
                
                // Если враг не выбран, проверяем расстояние
                if (!already_chosen) 
                {
                    var dist = point_distance(other.x, other.y, x, y);
                    if (dist < shortest_distance) 
                    {
                        shortest_distance = dist;
                        new_target = id;
                    }
                }
            }
        }
        
        // Если нашли подходящего врага, добавляем в массив выбранных
        if (instance_exists(new_target)) 
        {
            array_push(selected_targets, new_target);
        }
    }
    
    // Теперь создаем мультишот пули для каждой дополнительной цели
    for (var i = 1; i < array_length(selected_targets); i++) 
    {
        // Определяем тип мультишот пули (обычная или крит)
        var _bulletType;
        if (random(1) < global.crit_mod) {
            _bulletType = bullet_crit_multishot;
        } else {
            _bulletType = bullet_multishot;
        }
        
        // Создаем мультишот пулю
        var multishot_bullet = instance_create_layer(x, y, "Instances", _bulletType);
        
        // Передаем конкретную цель для этой пули
        with (multishot_bullet) 
        {
            target = other.selected_targets[i];
            
            // Направляем пулю к цели
            if (instance_exists(target))
            {
                direction = point_direction(x, y, target.x, target.y);
                image_angle = direction;
                speed = 6;
            }
            else
            {
                instance_destroy();
            }
            
            // Уменьшаем размер для визуального отличия
            image_xscale = 0.25;
            image_yscale = 0.25;
        }
    }
}

lifetime = 10;