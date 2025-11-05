// Функция для перемешивания массива
function shuffle_array_gm(arr) {
    var n = array_length(arr);
    for (var i = n - 1; i > 0; i--) {
        var j = irandom(i);
        var temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    return arr;
}

// Функция ограничения значения в диапазоне
function clamp_value(value, min_val, max_val) {
    if (value < min_val) return min_val;
    if (value > max_val) return max_val;
    return value;
}

// Основная функция генерации весов врагов
function generate_enemy_weights() {
    var _n = global.count_enemys_round;
    var _x = global.difficulty_round;
    var _val = global.budget_round;
    var _min_val = global.min_weight_mob_round;
    var _max_val = global.max_weight_mob_round;

    // Проверка минимальных требований
    if (_n > _val) {
        show_debug_message("Невозможно: n (" + string(_n) + ") > val (" + string(_val) + ")");
        return array_create(0);
    }
    if (_n < 1) {
        show_debug_message("n должно быть не меньше 1");
        return array_create(0);
    }
    if (_min_val > _max_val) {
        show_debug_message("Минимальное значение не может превышать максимальное");
        return array_create(0);
    }

    // Вычисляем идеальную сумму
    var ideal_sum = min(floor(_n * _x), _val, _max_val * _n);

    // Создаем массив target_values с равномерным распределением
    var target_values = array_create(_n, 0);
    if (_n == 1) {
        target_values[0] = (_min_val + _max_val) / 2;
    } else {
        var step = (_max_val - _min_val) / (_n - 1);
        for (var i = 0; i < _n; i++) {
            target_values[i] = _min_val + i * step;
        }
    }

    // Масштабируем target_values к ideal_sum
    var current_target_sum = 0;
    for (var i = 0; i < _n; i++) {
        current_target_sum += target_values[i];
    }

    var scaling_factor = ideal_sum / current_target_sum;
    var scaled_values = array_create(_n, 0);
    for (var i = 0; i < _n; i++) {
        scaled_values[i] = clamp_value(round(target_values[i] * scaling_factor), _min_val, _max_val);
    }

    // Корректировка остатка
    var current_sum = 0;
    for (var i = 0; i < _n; i++) {
        current_sum += scaled_values[i];
    }
    var remaining = ideal_sum - current_sum;

    // Добавляем остаток если нужно
    if (remaining > 0) {
        var indices = shuffle_array_gm(array_create(_n, 0));
        for (var i = 0; i < _n; i++) {
            if (remaining <= 0) break;
            var idx = indices[i];
            if (scaled_values[idx] < _max_val) {
                var add_amount = min(remaining, _max_val - scaled_values[idx]);
                scaled_values[idx] += add_amount;
                remaining -= add_amount;
            }
        }
    } else if (remaining < 0) {
        var indices = shuffle_array_gm(array_create(_n, 0));
        for (var i = 0; i < _n; i++) {
            if (remaining >= 0) break;
            var idx = indices[i];
            if (scaled_values[idx] > _min_val) {
                var remove_amount = min(-remaining, scaled_values[idx] - _min_val);
                scaled_values[idx] -= remove_amount;
                remaining += remove_amount;
            }
        }
    }

    // Финальная корректировка остатка
    if (remaining > 0) {
        for (var i = 0; i < _n; i++) {
            if (remaining <= 0) break;
            if (scaled_values[i] < _max_val) {
                scaled_values[i] += 1;
                remaining -= 1;
            }
        }
    } else if (remaining < 0) {
        for (var i = 0; i < _n; i++) {
            if (remaining >= 0) break;
            if (scaled_values[i] > _min_val) {
                scaled_values[i] -= 1;
                remaining += 1;
            }
        }
    }

    return scaled_values;
}

// Основной код спавна врагов
if global.pause == false && instance_exists(obj_tower) {
	
	global.count_enemys_round = global.difficult_level; // кол-во врагов
	global.difficulty_round += global.difficult_manager; //Коэф сложности
	global.budget_round +=  global.difficult_manager; // бюджет сценариста
	global.budget_round = round(global.budget_round)
	
	show_debug_message("кэф сложности: " + string(global.difficulty_round))
	show_debug_message("бюджет: " + string(global.budget_round))
    show_debug_message("врагов в раунде: " + string(global.count_enemys_round))

	show_debug_message(global.count_enemys_round);
    // Генерация массива весов врагов
    var enemy_weights = generate_enemy_weights();
    show_debug_message("Распределение сил врагов: " + string(enemy_weights));

    // Создаем врагов согласно difficult_level
    for (var i = 0; i < global.difficult_level; i++) {
        // Базовый радиус спавна
        var _spawnRadius = random_range(300, 500);
        
        // Равномерное распределение по кругу
        var _angleStep = 360 / global.difficult_level;
        var _baseAngle = _angleStep * i;
        var _randomAngle = _baseAngle + random_range(-45, 45);
        
        // Принудительно распределяем врагов по секторам
        if (enemy_counter % 4 == 0) {
            _randomAngle = (_randomAngle + 180) % 360;
        }
        
        // Вычисляем координаты спавна
        var _xx = obj_tower.x + lengthdir_x(_spawnRadius, _randomAngle);
        var _yy = obj_tower.y + lengthdir_y(_spawnRadius, _randomAngle);
        
        // Проверка коллизий с другими врагами
        var position_valid = true;
        with (obj_enemy) {
            if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
        }
        with (obj_enemy_fast) {
            if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
        }
        with (obj_enemy_big) {
            if (point_distance(_xx, _yy, x, y) < 100) position_valid = false;
        }
        with (obj_enemy_shoot) {
            if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
        }
        
        // Поиск альтернативной позиции при необходимости
        if (!position_valid) {
            var attempts = 0;
            var max_attempts = 8;
            
            while (!position_valid && attempts < max_attempts) {
                attempts++;
                var _angleOffset = random_range(-90, 90);
                _randomAngle = _baseAngle + _angleOffset;
                
                if (i % 2 == 0) {
                    _randomAngle = (_randomAngle + 180) % 360;
                }
                
                _spawnRadius = random_range(300, 500);
                _xx = obj_tower.x + lengthdir_x(_spawnRadius, _randomAngle);
                _yy = obj_tower.y + lengthdir_y(_spawnRadius, _randomAngle);
                
                // Повторная проверка коллизий
                position_valid = true;
                with (obj_enemy) {
                    if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
                }
                with (obj_enemy_fast) {
                    if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
                }
                with (obj_enemy_big) {
                    if (point_distance(_xx, _yy, x, y) < 100) position_valid = false;
                }
                with (obj_enemy_shoot) {
                    if (point_distance(_xx, _yy, x, y) < 80) position_valid = false;
                }
            }
        }
        
        // Принудительное размещение если нужно
        if (!position_valid) {
            var _forcedAngle = random_range(0, 360);
            _spawnRadius = random_range(300, 600);
            _xx = obj_tower.x + lengthdir_x(_spawnRadius, _forcedAngle);
            _yy = obj_tower.y + lengthdir_y(_spawnRadius, _forcedAngle);
        }
        
        // Выбор типа врага на основе веса
        var _enemyType;
        var current_weight = enemy_weights[i];
        switch (current_weight) {
            case 1: // вес 1
                enemy_type_count = array_length(global.weight_enemy_1);
                num_enemy_type = irandom(enemy_type_count - 1);
                _enemyType = global.weight_enemy_1[num_enemy_type];
                break;
            case 2: // вес 2
                enemy_type_count = array_length(global.weight_enemy_2);
                num_enemy_type = irandom(enemy_type_count - 1);
                _enemyType = global.weight_enemy_2[num_enemy_type];
                break;
            case 3: // вес 3
                enemy_type_count = array_length(global.weight_enemy_3);
                num_enemy_type = irandom(enemy_type_count - 1);
                _enemyType = global.weight_enemy_3[num_enemy_type];
                break;
            case 4: // вес 4
                enemy_type_count = array_length(global.weight_enemy_4);
                num_enemy_type = irandom(enemy_type_count - 1);
                _enemyType = global.weight_enemy_4[num_enemy_type];
                break;
            case 6: // вес 5
                enemy_type_count = array_length(global.weight_enemy_6);
                num_enemy_type = irandom(enemy_type_count - 1);
                _enemyType = global.weight_enemy_6[num_enemy_type];
                break;
            default:
                _enemyType = global.weight_enemy_1[0];
                break;
        }
        
        // Создание врага
        instance_create_layer(_xx, _yy, "Instances", _enemyType);
        enemy_counter = (enemy_counter + 1) % 10;
    }
}

// Перезапуск таймера спавна
alarm[0] = room_speed * 2;