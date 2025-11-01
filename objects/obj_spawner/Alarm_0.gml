// Проверяем, существует ли игрок
if (instance_exists(obj_tower)) {
    // Создаем global.difficult_level врагов
    for (var i = 0; i < global.difficult_level; i++) {
        // Рандомизируем радиус спавна от 300 до 500
        var _spawnRadius = random_range(300, 500);
        
        // Вычисляем угол для равномерного распределения вокруг игрока
        var _angleStep = 360 / global.difficult_level;
        var _baseAngle = _angleStep * i;
        
        // Добавляем небольшой случайный разброс к углу
        var _randomAngle = _baseAngle + random_range(-30, 30);
        
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
            if (point_distance(_xx, _yy, x, y) < 100) { // Большим врагам нужно больше места
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
            var max_attempts = 10;
            
            while (!position_valid && attempts < max_attempts) {
                attempts++;
                
                // Пробуем другой угол и другой радиус
                _randomAngle = random_range(0, 360);
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
        
        // Если так и не нашли свободную позицию, используем исходную с небольшим смещением
        if (!position_valid) {
            _spawnRadius = random_range(300, 1000);
            _xx = obj_tower.x + lengthdir_x(_spawnRadius, _randomAngle) + random_range(-50, 50);
            _yy = obj_tower.y + lengthdir_y(_spawnRadius, _randomAngle) + random_range(-50, 50);
        }
        
        // Создаем моба (можно выбрать случайного из нескольких)
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
        with (instance_create_layer(_xx, _yy, "Instances", _enemyType)) { 
            
        };
    }
}

// Перезапускаем alarm для следующего спавна
alarm[0] = room_speed * 2; // Спавн раз в 2 секунду