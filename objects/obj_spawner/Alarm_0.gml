// Проверяем, существует ли игрок
if (instance_exists(obj_tower)) {
    // Создаем global.difficult_level врагов
    for (var i = 0; i < global.difficult_level; i++) {
        // Базовый радиус спавна
        var _spawnRadius = random_range(300, 500);
        
        // Равномерное распределение по кругу с принудительным смещением
        var _angleStep = 360 / global.difficult_level;
        var _baseAngle = _angleStep * i;
        
        // Добавляем случайный разброс, но ограничиваем его для равномерности
        var _randomAngle = _baseAngle + random_range(-45, 45);
        
        // Принудительно распределяем врагов по всем секторам
        // Если это четный враг, смещаем его в другую половину круга
        if (enemy_counter % 4 == 0) {
            _randomAngle = (_randomAngle + 180) % 360;
        }
        
        // Вычисляем координаты для спавна
        var _xx = obj_tower.x + lengthdir_x(_spawnRadius, _randomAngle);
        var _yy = obj_tower.y + lengthdir_y(_spawnRadius, _randomAngle);
        
        // Проверяем, не находится ли позиция слишком близко к другим врагам
        var position_valid = true;
        with (obj_enemy) {
            if (point_distance(_xx, _yy, x, y) < 80) {
                position_valid = false;
            }
        }
        with (obj_enemy_fast) {
            if (point_distance(_xx, _yy, x, y) < 80) {
                position_valid = false;
            }
        }
        with (obj_enemy_big) {
            if (point_distance(_xx, _yy, x, y) < 100) {
                position_valid = false;
            }
        }
        with (obj_enemy_shoot) {
            if (point_distance(_xx, _yy, x, y) < 80) {
                position_valid = false;
            }
        }
        
        // Если позиция занята, ищем альтернативную
        if (!position_valid) {
            // Пытаемся найти свободную позицию вблизи исходной
            var attempts = 0;
            var max_attempts = 8;
            
            while (!position_valid && attempts < max_attempts) {
                attempts++;
                
                // Пробуем другой угол в том же секторе
                var _angleOffset = random_range(-90, 90);
                _randomAngle = _baseAngle + _angleOffset;
                
                // Для четных врагов смещаем в другую половину
                if (i % 2 == 0) {
                    _randomAngle = (_randomAngle + 180) % 360;
                }
                
                _spawnRadius = random_range(300, 500);
                _xx = obj_tower.x + lengthdir_x(_spawnRadius, _randomAngle);
                _yy = obj_tower.y + lengthdir_y(_spawnRadius, _randomAngle);
                
                // Снова проверяем позицию
                position_valid = true;
                with (obj_enemy) {
                    if (point_distance(_xx, _yy, x, y) < 80) {
                        position_valid = false;
                    }
                }
                with (obj_enemy_fast) {
                    if (point_distance(_xx, _yy, x, y) < 80) {
                        position_valid = false;
                    }
                }
                with (obj_enemy_big) {
                    if (point_distance(_xx, _yy, x, y) < 100) {
                        position_valid = false;
                    }
                }
                with (obj_enemy_shoot) {
                    if (point_distance(_xx, _yy, x, y) < 80) {
                        position_valid = false;
                    }
                }
            }
        }
        
        // Если так и не нашли свободную позицию, используем принудительное размещение
        if (!position_valid) {
            // Размещаем врага в заранее определенном секторе
            var _forcedAngle = random_range(0, 360);
            _spawnRadius = random_range(300, 600);
            _xx = obj_tower.x + lengthdir_x(_spawnRadius, _forcedAngle);
            _yy = obj_tower.y + lengthdir_y(_spawnRadius, _forcedAngle);
        }
        
        // Создаем моба
        var _enemyType;
        var rand = irandom(100);
        if (rand < global.enemy_chance) {
            _enemyType = obj_enemy;
        } else if (rand < global.enemy_fast_chance + global.enemy_chance) {
            _enemyType = obj_enemy_fast;
        } else if (rand < global.enemy_big_chance + global.enemy_fast_chance + global.enemy_chance) {
            _enemyType = obj_enemy_big;
        } else {
            _enemyType = obj_enemy_shoot;
        }
        
        enemy_counter += 1;
        if (enemy_counter == 10) {
            enemy_counter = 0;
        }
        
        // Создаем врага
        instance_create_layer(_xx, _yy, "Instances", _enemyType);
    }
}

// Перезапускаем alarm для следующего спавна
alarm[0] = room_speed * 2;