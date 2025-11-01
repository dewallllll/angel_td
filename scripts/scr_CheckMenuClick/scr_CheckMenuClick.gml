function scr_CheckMenuClick(mouse_x_gui, mouse_y_gui) {
    // Проверяем, находится ли курсор в области меню
    if (mouse_y_gui < menuY) return;
    
    var _currentMenuArray = menu[currentMenu];
    
    if (currentMenu == MENU_MAIN) {
        // Обработка кликов в главном меню
        for (var i = 0; i < array_length(_currentMenuArray); i++) {
            var _elementX = display_get_gui_width() / 2;
            var _elementY = menuY + 50 + i * 30;
            var _elementWidth = 200;
            var _elementHeight = 25;
            
            if (point_in_rectangle(mouse_x_gui, mouse_y_gui, 
                _elementX - _elementWidth/2, _elementY - _elementHeight/2,
                _elementX + _elementWidth/2, _elementY + _elementHeight/2)) {
                
                // Используем with (self) для изменения переменных объекта
                with (self) {
                    switch(i) {
                        case 0: currentMenu = MENU_DAMAGE; break;
                        case 1: currentMenu = MENU_DEFENSE; break;
                        case 2: currentMenu = MENU_ECONOMY; break;
                    }
                    currentIndex = 0;
                }
                break;
            }
        }
    } else {
        // Обработка кликов в подменю
        var _startX = itemSpacing - currentScroll;
        var _baseY = menuY + 20;
        
        for (var i = 0; i < array_length(_currentMenuArray); i++) {
            var _item = _currentMenuArray[i];
            var _elementX = _startX + i * (itemWidth + itemSpacing);
            var _elementY = _baseY;
            
            if (point_in_rectangle(mouse_x_gui, mouse_y_gui, 
                _elementX, _elementY, 
                _elementX + itemWidth, _elementY + itemHeight)) {
                show_debug_message(">>> Попадание в элемент " + string(i) + "! <<<");
				show_debug_message(_item);
                with (self) {
                    if (is_struct(_item)) {
						show_debug_message("Вызов scr_ApplyUpgrade...");
						 
                        scr_ApplyUpgrade(_item);
                    } else if (_item == "Назад") {
                        currentMenu = MENU_MAIN;
                        currentIndex = 0;
                    }
                }
                break;
            }
        }
    }
}