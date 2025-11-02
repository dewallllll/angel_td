// Проверяем, существует ли враг
if (instance_exists(obj_tower)) {
    // Создаем пули с разбросом по кругу   
    var _bulletType = obj_enemy_bullet;

        // Создаем пулю со смещением
    var new_bullet = instance_create_layer(x, y, "Instances", _bulletType);
        
        // Настраиваем пулю через with
        with (new_bullet) {
            image_xscale = 0.5;
            image_yscale = 0.5;         
        }
    }
    
    

// Перезапускаем alarm
alarm[0] = room_speed * 2;