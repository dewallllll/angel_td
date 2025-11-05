function script_pick_random_perks(_player_level) {
    show_debug_message("=== PICK_RANDOM_PERKS START ===");
    
    var _candidate_list = ds_list_create();
    var _weight_list = ds_list_create();
    var _total_weight = 0;
    var _available_perks_count = 0;
    
    // ===== ФИЛЬТРАЦИЯ ПЕРКОВ =====
    for (var i = 0; i < ds_list_size(global.perk_list); i++) {
        var _perk_map = global.perk_list[| i];
        
        // БЕЗОПАСНАЯ ПРОВЕРКА: убедимся, что перк действителен
        if (is_undefined(_perk_map) || !ds_exists(_perk_map, ds_type_map)) {
            show_debug_message("Пропуск: недействительный perk_map в индексе " + string(i));
            continue;
        }
        
        // БЕЗОПАСНОЕ ПОЛУЧЕНИЕ ИМЕНИ ПЕРКА
        var _perk_name = _perk_map[? "name"];
        if (is_undefined(_perk_name) || _perk_name == "") {
            show_debug_message("Пропуск: perk_map без имени в индексе " + string(i));
            continue;
        }
        
        // ===== ПРОВЕРКА МАКСИМАЛЬНОГО УРОВНЯ =====
        var _max_level = _perk_map[? "max_level"];
        var _current_level = 0;
        
        // Безопасно получаем текущий уровень перка
        if (ds_map_exists(global.perk_levels, _perk_name)) {
            _current_level = global.perk_levels[? _perk_name];
        }
        
        // СТРОГАЯ ПРОВЕРКА МАКСИМАЛЬНОГО УРОВНЯ
        // Если перк достиг максимального уровня, полностью исключаем его
        if (_max_level > 0 && _current_level >= _max_level) {
            show_debug_message("Пропуск " + _perk_name + ": достигнут макс. уровень " + string(_max_level));
            continue;
        }
        
        // ===== ПРОВЕРКА ЗАВИСИМОСТЕЙ =====
        var _requirement = _perk_map[? "requirement"];
        if (!is_undefined(_requirement) && _requirement != undefined) {
            // Вызываем функцию-проверку зависимости с обработкой ошибок
            var requirement_met = false;
            try {
                requirement_met = _requirement();
            } catch (e) {
                show_debug_message("Ошибка в проверке требования для " + _perk_name + ": " + string(e));
                requirement_met = false;
            }
            
            if (!requirement_met) {
                show_debug_message("Пропуск " + _perk_name + ": не выполнены требования");
                continue;
            }
        }
        
        // ===== РАСЧЕТ ВЕСА С УЧЕТОМ УРОВНЯ =====
        var _rarity = _perk_map[? "rarity"];
        var _base_w = _perk_map[? "base_weight"];
        
        // Уменьшаем вес если перк уже прокачан
        var _level_penalty = _current_level * 10;
        var _current_weight = _base_w + (_rarity * _player_level * 5) - _level_penalty;
        _current_weight = max(_current_weight, 5); // Минимальный вес 5
        
        ds_list_add(_candidate_list, _perk_map);
        ds_list_add(_weight_list, _current_weight);
        _total_weight += _current_weight;
        _available_perks_count++;
        
        show_debug_message("Кандидат: " + _perk_name + " ур." + string(_current_level) + 
                          "/" + string(_max_level) + " вес: " + string(_current_weight));
    }
    
    show_debug_message("Доступно перков для выбора: " + string(_available_perks_count));
    
    // ===== ВЫБОР 3 ПЕРКОВ =====
    var _chosen_perks = [];
    
    if (_total_weight <= 0 || ds_list_size(_candidate_list) == 0) {
        show_debug_message("Нет доступных перков для выбора!");
        ds_list_destroy(_candidate_list);
        ds_list_destroy(_weight_list);
        return _chosen_perks; // Возвращаем пустой массив
    }
    
    // Выбираем не более 3 перков, но не больше чем доступно
    var _num_to_pick = min(3, ds_list_size(_candidate_list));
    
    repeat(_num_to_pick) {
        var _rand = random(_total_weight);
        var _running_total = 0;
        var _found = false;
        
        for (var j = 0; j < ds_list_size(_weight_list); j++) {
            _running_total += _weight_list[| j];
            if (_rand < _running_total) {
                var _picked_perk = _candidate_list[| j];
                
                // Дополнительная проверка перед добавлением
                if (ds_exists(_picked_perk, ds_type_map)) {
                    var perk_name = _picked_perk[? "name"];
                    if (!is_undefined(perk_name) && perk_name != "") {
                        array_push(_chosen_perks, _picked_perk);
                        _found = true;
                    }
                }
                
                // Удаляем выбранный перк из списков
                if (_found) {
                    _total_weight -= _weight_list[| j];
                    ds_list_delete(_candidate_list, j);
                    ds_list_delete(_weight_list, j);
                }
                break;
            }
        }
        
        // Если не нашли подходящий перк, прерываем цикл
        if (!_found) break;
    }
    
    ds_list_destroy(_candidate_list);
    ds_list_destroy(_weight_list);
    
    show_debug_message("Выбрано перков: " + string(array_length(_chosen_perks)));
    show_debug_message("=== PICK_RANDOM_PERKS END ===");
    return _chosen_perks;
}