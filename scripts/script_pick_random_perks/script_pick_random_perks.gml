// Скрипт: script_pick_random_perks
function script_pick_random_perks(_player_level) {
    // Создаем временные списки для кандидатов и их весов
    var _candidate_list = ds_list_create();   // Здесь храним все перки-кандидаты
    var _weight_list = ds_list_create();      // Здесь храним РАСЧЕТНЫЕ веса каждого перка
    var _total_weight = 0;                    // Сумма ВСЕХ весов для случайного выбора
    
    // ===== ЭТАП 1: РАССЧИТЫВАЕМ ТЕКУЩИЕ ВЕСА С УЧЕТОМ УРОВНЯ =====
    for (var i = 0; i < ds_list_size(global.perk_list); i++) {
        // Достаем перк из общего списка по индексу i
        var _perk_map = global.perk_list[| i];
        
        // Получаем свойства перка (знак [?] - получить значение по ключу из ds_map)
        var _rarity = _perk_map[? "rarity"];      // Редкость перка (0, 1, 2...)
        var _base_w = _perk_map[? "base_weight"]; // Базовый вес из настроек
        
        // ===== ВАЖНАЯ ФОРМУЛА: УВЕЛИЧЕНИЕ ШАНСОВ РЕДКИХ ПЕРКОВ С УРОВНЕМ =====
        // Чем выше уровень и редкость - тем больше прибавка к весу
        // Например: 
        // - Обычный перк (редкость 0): 60 + (0 * 10 * 5) = 60 (не меняется)
        // - Редкий перк (редкость 1) на 10 уровне: 30 + (1 * 10 * 5) = 80 (стал чаще!)
        var _current_weight = _base_w + (_rarity * global.current_level * 5);
        
        // Добавляем перк и его расчетный вес в наши временные списки
        ds_list_add(_candidate_list, _perk_map);
        ds_list_add(_weight_list, _current_weight);
        _total_weight += _current_weight; // Суммируем общий вес
    }
    
    // ===== ЭТАП 2: ВЫБИРАЕМ 3 СЛУЧАЙНЫХ ПЕРКА =====
    var _chosen_perks = []; // Массив для хранения выбранных перков
    
    repeat(3) { // Повторяем 3 раза - нужно выбрать 3 перка
        if (_total_weight <= 0) break; // Защита от ошибки, если весов не осталось
        
        // Генерируем случайное число от 0 до общей суммы весов
        // Это как будто мы бросаем дротик в линейку, где у каждого перка свой отрезок
        var _rand = random(_total_weight);
        var _running_total = 0; // Бегущая сумма для поиска выбранного перка
        
        // Проходим по всем весам, чтобы найти какой перк выбран
        for (var j = 0; j < ds_list_size(_weight_list); j++) {
            _running_total += _weight_list[| j]; // Добавляем вес текущего перка
            
            // Если наше случайное число попало в отрезок этого перка - ВЫБИРАЕМ ЕГО!
            if (_rand < _running_total) {
                var _picked_perk = _candidate_list[| j];
                array_push(_chosen_perks, _picked_perk); // Сохраняем выбранный перк
                
                // ===== УДАЛЯЕМ ВЫБРАННЫЙ ПЕРК ИЗ СПИСКОВ =====
                // Чтобы не было повторов в одной выборке
                _total_weight -= _weight_list[| j]; // Уменьшаем общий вес
                ds_list_delete(_candidate_list, j); // Удаляем перк из кандидатов
                ds_list_delete(_weight_list, j);    // Удаляем его вес
                break; // Выходим из цикла for - перк найден
            }
        }
    }
    
    // ===== ЭТАП 3: ЧИСТИМ ПАМЯТЬ И ВОЗВРАЩАЕМ РЕЗУЛЬТАТ =====
    ds_list_destroy(_candidate_list); // Удаляем временные списки (важно для оптимизации!)
    ds_list_destroy(_weight_list);
    
    return _chosen_perks; // Возвращаем массив из 3 выбранных перков
}