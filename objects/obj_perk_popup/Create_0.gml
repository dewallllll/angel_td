visible = false;
perks = [];
selected_index = -1;
card_width = 300;
card_height = 400;
card_spacing = 50;

// Флаг для отслеживания активности
is_active = false;

// Функция показа меню
show_perk_popup = function() {
	global.pause = true
	show_debug_message(string(global.pause))
	show_debug_message("Пауза поставлена")
    visible = true;
    is_active = true;
    
    
    
    // Получаем перки
    perks = script_pick_random_perks(global.current_level);
    
    // Если скрипт вернул пустой массив, создаем тестовые данные
    if (array_length(perks) == 0) {
        show_debug_message("Creating test perks...");
        perks = [];
        for (var i = 0; i < 3; i++) {
            var test_perk = ds_map_create();
            ds_map_add(test_perk, "name", "Тест перк " + string(i));
            ds_map_add(test_perk, "effect", "Тестовый эффект");
            ds_map_add(test_perk, "rarity", 0);
            array_push(perks, test_perk);
        }
    }
    
    selected_index = -1;
    
    // Рассчитываем позиции карточек
    var screen_width = display_get_width();
    var total_width = (card_width * 3) + (card_spacing * 2);
    start_x = (screen_width - total_width) / 2;
    
    show_debug_message("Popup shown with " + string(array_length(perks)) + " perks");
    show_debug_message("Screen: " + string(screen_width) + "x" + string(display_get_height()));
}

// Функция скрытия меню
hide_perk_popup = function() {
    visible = false;
	global.pause = false
	show_debug_message("Пауза снята")
	show_debug_message(string(global.pause))
    is_active = false;
    show_debug_message("Popup hidden");
}