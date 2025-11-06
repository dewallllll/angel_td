function apply_perk_effect(_perk) {
    var _perk_name = _perk[? "name"];
    show_debug_message(string(_perk_name))
	 // ===== УВЕЛИЧИВАЕМ УРОВЕНЬ ПЕРКА =====
    var _current_level = 0;
    if (ds_map_exists(global.perk_levels, _perk_name)) {
        _current_level = global.perk_levels[? _perk_name];
        global.perk_levels[? _perk_name] = _current_level + 1;
    } else {
        ds_map_add(global.perk_levels, _perk_name, 1);
        _current_level = 1;
    }
    
    var _new_level = _current_level + 1;
    show_debug_message("Уровень " + _perk_name + ": " + string(_current_level) + " -> " + string(_new_level));
	
    // В зависимости от имени перка применяем соответствующий эффект
    switch (_perk_name) {
        case "Кол-во мультишота":
            global.multishot_count += 1; 
            showw_message("Кол-во снарядов мультишота увеличено");
			global.pause = false
            break;
            
        case "Шанс мультишота":
            global.multishot_chance += 0.1; 
            showw_message("Шанс мультишота увеличен");
			global.pause = false
            break;
            
        case "Кол-во выстрелов":
            global.shot_count += 1; 
            showw_message("Кол-во выстрелов увеличено");
			global.pause = false
            break;
			
		case "Шанс повторного выстрела":
            global.shot_count_chance += 0.1; 
            showw_message("Шанс на увеличение кол-ва выстрелов увеличен");
			global.pause = false
            break;
			
		case "Шанс отскока":
            global.bounce_shot_chance += 0.1; 
            showw_message("Шанс на отскок увеличен");
			global.pause = false
            break;
			
		case "Кол-во отскоков":
            global.bounce_shot_chance += 0.1; 
            showw_message("Кол-во отскоков увеличено");
			global.pause = false
            break;
			
			//прек для улучшения случайного атрибута если перки закончились
		case "Улучшить случайный атрибут":
		    apply_random_attribute_boost();
			show_debug_message("Случайный атрибут улучшен!")
		    break;
            
        // Добавляем обработку остальных перков по такому же принципу
    }
    
    
}

