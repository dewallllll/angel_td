// Проверяем, существует ли враг
var _enemy_in_range = collision_circle(x, y, global.attack_radius, obj_enemy_parent, false, true);

if (instance_exists(_enemy_in_range)) {
    // Сохраняем текущую скорость атаки
    var cur_as = global.attack_speed;
    
    // Временно увеличиваем скорость атаки для залпа
    global.attack_speed = 0.1;
    
    // Создаем пули с разбросом по кругу
    for(var i = 0; i <= global.shot_count; i++) {
        var _bulletType;
        
        // Определяем тип пули (обычная или крит)
        if (random(1) < global.crit_mod) {
            _bulletType = bullet_crit;
        } else {
            _bulletType = bullet;
        }
        
        // Вычисляем угол для текущей пули (равномерное распределение по кругу)
        var _angle = (i / (global.shot_count + 1)) * 360;
        
        // Смещаем пулю от центра башни (радиус 20 пикселей)
        var _offset_x = lengthdir_x(20, _angle);
        var _offset_y = lengthdir_y(20, _angle);
        
        // Создаем пулю со смещением
        var new_bullet = instance_create_layer(x + _offset_x, y + _offset_y, "Instances", _bulletType);
        
        // Настраиваем пулю через with
        with (new_bullet) {
            image_xscale = 1;
            image_yscale = 1;
            bounce_chance = global.bounce_shot_chance
            // Убедимся, что это не мультишот пуля
            is_multishot = false;
        }
    }
    
    // Восстанавливаем исходную скорость атаки
    global.attack_speed = cur_as;
}

// Перезапускаем alarm
alarm[0] = room_speed * global.attack_speed;