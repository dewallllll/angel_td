if (!is_active) exit;

// Обрабатываем клик мыши
if (mouse_check_button_pressed(mb_left)) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    show_debug_message("Mouse clicked at: " + string(mx) + ", " + string(my));
    
    // Проверяем клик по каждой карточке
    for (var i = 0; i < array_length(perks); i++) {
        if (is_undefined(perks[i])) continue;
        
        var card_x = start_x + i * (card_width + card_spacing);
        var card_y = (display_get_height() - card_height) / 2;
        
        show_debug_message("Card " + string(i) + " area: " + string(card_x) + "," + string(card_y) + " to " + string(card_x + card_width) + "," + string(card_y + card_height));
        
        // Проверяем попадание в карточку
        if (mx >= card_x && mx <= card_x + card_width && 
            my >= card_y && my <= card_y + card_height) {
            
            show_debug_message("PERK " + string(i) + " CLICKED! - " + string(perks[i][? "name"]));
            
            // Применяем перк
            apply_perk_effect(perks[i]);
            
            // Скрываем меню
            hide_perk_popup();
			global.pause = false
            
            // Выходим после первого найденного клика
            break;
        }
    }
}

