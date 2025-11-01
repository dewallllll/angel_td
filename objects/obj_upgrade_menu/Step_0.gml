// Обновление логики меню
var _guiWidth = display_get_gui_width();
var _currentMouseX = device_mouse_x_to_gui(0);
var _currentMouseY = device_mouse_y_to_gui(0);

// Обработка прокрутки колесиком мыши
if (mouse_wheel_up()) {
    currentScroll -= 30;
}
if (mouse_wheel_down()) {
    currentScroll += 30;
}

// Обработка перетаскивания (свайпа)
if (device_mouse_check_button(0, mb_left)) {
    // Проверяем, находится ли курсор в области меню
    if (point_in_rectangle(_currentMouseX, _currentMouseY, 0, menuY, _guiWidth, display_get_gui_height())) {
        if (!isDragging) {
            isDragging = true;
            dragStartX = _currentMouseX;
            scrollVelocity = 0;
        } else {
            var _deltaX = _currentMouseX - dragStartX;
            currentScroll -= _deltaX;
            scrollVelocity = -_deltaX;
            dragStartX = _currentMouseX;
        }
    }
} else {
    isDragging = false;
    // Инерция прокрутки
    if (abs(scrollVelocity) > 0.1) {
        currentScroll += scrollVelocity;
        scrollVelocity *= 0.9; // Замедление
    } else {
        scrollVelocity = 0;
    }
}

// Обработка подтверждения выбора клавишей Enter
if (keyboard_check_pressed(vk_enter)) {
    var _currentMenuArray = menu[currentMenu];
    
    if (currentMenu == MENU_MAIN) {
        // В главном меню: переход в выбранный раздел
        switch(currentIndex) {
            case 0: currentMenu = MENU_DAMAGE; break;
            case 1: currentMenu = MENU_DEFENSE; break;
            case 2: currentMenu = MENU_ECONOMY; break;
        }
        currentIndex = 0; // Сброс индекса при входе в новый раздел
    } else {
        // В подменю: обработка улучшения или возврата
        if (is_array(_currentMenuArray[currentIndex])) {
            var _item = _currentMenuArray[currentIndex];
            scr_ApplyUpgrade(_item);
        } else if (_currentMenuArray[currentIndex] == "Назад") {
            // Возврат в главное меню
            currentMenu = MENU_MAIN;
            currentIndex = 0;
        }
    }
}

// Ограничение прокрутки
currentScroll = clamp(currentScroll, 0, maxScroll);

// Проверка клика по элементу меню
if (mouse_check_button_released(mb_left)) {
    scr_CheckMenuClick(_currentMouseX, _currentMouseY);
}