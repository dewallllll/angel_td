if (random(1) < global.bounce_shot_chance) {
	show_debug_message("баунс");
    // Ищем ближайшего врага, исключая уже выбранные цели
var nearest_enemy = noone;
var shortest_distance = 1000000;

with (obj_enemy_parent) 
{
    if (instance_exists(id))
    {
        // Проверяем, не исключен ли этот враг
        var is_excluded = false;
        if (variable_instance_exists(other.id, "excluded_targets")) {
            for (var i = 0; i < array_length(other.excluded_targets); i++) 
            {
                if (other.excluded_targets[i] == id) 
                {
                    is_excluded = true;
                    break;
                }
            }
        }
        
        // Если враг не исключен, проверяем расстояние
        if (!is_excluded) 
        {
            var dist = point_distance(other.x, other.y, x, y);
            if (dist < shortest_distance) 
            {
                shortest_distance = dist;
                nearest_enemy = id;
            }
        }
    }
}

// Устанавливаем цель
target = nearest_enemy;
	cur_bounce_count += 1
}
else {
lifetime -= 10;
}
if cur_bounce_count >= global.bounce_shot_count {
	lifetime -= 10;
}