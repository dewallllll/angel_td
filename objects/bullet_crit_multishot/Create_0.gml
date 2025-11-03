//шанс отскока
bounce_chance = 0; // Значение по умолчанию
// Флаг для определения мультишот пуль
is_multishot = true;

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

// Если враг найден, рассчитываем направление и задаем скорость
if (instance_exists(target))
{
    direction = point_direction(x, y, target.x, target.y);
    image_angle = direction;
    speed = 6;
    
    // Обновляем массив исключенных целей у родительской пули
    // Находим основную пулю (не мультишот)
    var main_bullet = noone;
    with (bullet) 
    {
        if (!is_multishot && instance_exists(id)) 
        {
            main_bullet = id;
            break;
        }
    }
    
    // Если нашли основную пулю, обновляем массив выбранных целей
    if (instance_exists(main_bullet) && variable_instance_exists(main_bullet, "selected_targets")) 
    {
        // Находим индекс заполнителя в массиве выбранных целей
        for (var i = 0; i < array_length(main_bullet.selected_targets); i++) 
        {
            if (!instance_exists(main_bullet.selected_targets[i])) 
            {
                main_bullet.selected_targets[i] = target;
                break;
            }
        }
    }
}
else 
{
    instance_destroy();
}

lifetime = 10;