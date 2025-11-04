function apply_perk_effect(_perk) {
    var perk_name = _perk[? "name"];
    
    // В зависимости от имени перка применяем соответствующий эффект
    switch (perk_name) {
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
			
		case "Кол-во выстрелов: шанс":
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
            
        // Добавляем обработку остальных перков по такому же принципу
    }
    
    // Проигрываем звук выбора перка
    //audio_play_sound(snd_perk_pick, 1, false);
}