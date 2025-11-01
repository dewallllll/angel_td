// Временная отладка - отображаем текущее состояние меню
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(10, 10, "Текущее меню: " + string(currentMenu));

// Рисуем фон меню
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, menuY, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

draw_set_font(cs);
draw_set_halign(fa_center);

// Отрисовка в зависимости от текущего раздела
switch (currentMenu) {
    case MENU_MAIN:
        // Отрисовка главного меню (категорий)
        for (var i = 0; i < array_length(menu[MENU_MAIN]); i++) {
            var _elementX = display_get_gui_width() / 2;
            var _elementY = menuY + 50 + i * 30;
            
            // Подсветка выбранного элемента
            draw_set_color(i == currentIndex ? c_yellow : c_white);
            draw_text(_elementX, _elementY, menu[MENU_MAIN][i]);
        }
        break;
    
    case MENU_DAMAGE:
        // Отрисовка меню урона
        var _startX = itemSpacing - currentScroll;
        var _baseY = menuY + 20;
        var _currentMenuArray = menu[MENU_DAMAGE];
        
        for (var i = 0; i < array_length(_currentMenuArray); i++) {
            var _item = _currentMenuArray[i];
            var _elementX = _startX + i * (itemWidth + itemSpacing);
            var _elementY = _baseY;
            
            // Пропускаем элементы, выходящие за границы видимости
            if (_elementX + itemWidth < 0 || _elementX > display_get_gui_width()) continue;
            
            // Рисуем фон элемента
            draw_set_color(i == selectedIndex ? c_yellow : c_white);
            draw_rectangle(_elementX, _elementY, _elementX + itemWidth, _elementY + itemHeight, false);
            
            // Обычный элемент улучшения
            if (is_struct(_item)) {
                // Название атрибута (верхняя строка)
                draw_set_color(c_green);
                draw_text(_elementX + itemWidth / 2, _elementY + 15, _item.name);
                
                // Текущее значение атрибута (вторая строка)
                var _currentValue = 0;
                switch (_item.name) {
                    case "Урон": _currentValue = global.dmg; break;
                    case "Скорость атаки": _currentValue = global.attack_speed; break;
                    case "Шанс крита": _currentValue = global.crit_mod; break;
                    case "Урон крита": _currentValue = global.crit_dmg_mod; break;
					case "Радиус атаки": _currentValue = global.attack_radius; break;
                    default: _currentValue = 0; break;
                }
                draw_text(_elementX + itemWidth / 2, _elementY + 35, "Тек: " + string(_currentValue));
                

                
                // Стоимость или "МАКС" (четвертая строка)
                if (_item.currentLevel < _item.maxLevel) {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, string(_item.cost) + " $");
                } else {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, "МАКС");
                }
                
                // Спрайт (рисуем слева от текста)
                if (sprite_exists(_item.sprite)) {
                    draw_sprite(_item.sprite, 0, _elementX + 20, _elementY + 45);
                }
            }
            // Кнопка "Назад"
            else if (is_string(_item)) {
                draw_set_color(c_red);
                draw_text(_elementX + itemWidth / 2, _elementY + itemHeight / 2, _item);
            }
        }
        break;
    
    case MENU_DEFENSE:
        // Отрисовка меню защиты
        var _startX = itemSpacing - currentScroll;
        var _baseY = menuY + 20;
        var _currentMenuArray = menu[MENU_DEFENSE];
        
        for (var i = 0; i < array_length(_currentMenuArray); i++) {
            var _item = _currentMenuArray[i];
            var _elementX = _startX + i * (itemWidth + itemSpacing);
            var _elementY = _baseY;
            
            if (_elementX + itemWidth < 0 || _elementX > display_get_gui_width()) continue;
            
            draw_set_color(i == selectedIndex ? c_yellow : c_white);
            draw_rectangle(_elementX, _elementY, _elementX + itemWidth, _elementY + itemHeight, false);
            
            if (is_struct(_item)) {
                draw_set_color(c_green);
                draw_text(_elementX + itemWidth / 2, _elementY + 15, _item.name);
                
                var _currentValue = 0;
                switch (_item.name) {
                    case "ХП": _currentValue = global.max_tower_hp; break;
                    case "Реген": _currentValue = global.hp_regen; break;
                    case "Броня": _currentValue = global.tower_armor; break;
                    case "Процент брони": _currentValue = global.tower_armor_percent; break;
                    default: _currentValue = 0; break;
                }
                draw_text(_elementX + itemWidth / 2, _elementY + 35, "Тек: " + string(_currentValue));
                
                if (_item.currentLevel < _item.maxLevel) {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, string(_item.cost) + " $");
                } else {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, "МАКС");
                }
                
                if (sprite_exists(_item.sprite)) {
                    draw_sprite(_item.sprite, 0, _elementX + 20, _elementY + 45);
                }
            }
            else if (is_string(_item)) {
                draw_set_color(c_red);
                draw_text(_elementX + itemWidth / 2, _elementY + itemHeight / 2, _item);
            }
        }
        break;
    
    case MENU_ECONOMY:
        // Отрисовка меню экономики
        var _startX = itemSpacing - currentScroll;
        var _baseY = menuY + 20;
        var _currentMenuArray = menu[MENU_ECONOMY];
        
        for (var i = 0; i < array_length(_currentMenuArray); i++) {
            var _item = _currentMenuArray[i];
            var _elementX = _startX + i * (itemWidth + itemSpacing);
            var _elementY = _baseY;
            
            if (_elementX + itemWidth < 0 || _elementX > display_get_gui_width()) continue;
            
            draw_set_color(i == selectedIndex ? c_yellow : c_white);
            draw_rectangle(_elementX, _elementY, _elementX + itemWidth, _elementY + itemHeight, false);
            
            if (is_struct(_item)) {
                draw_set_color(c_green);
                draw_text(_elementX + itemWidth / 2, _elementY + 15, _item.name);
                
                var _currentValue = 0;
                switch (_item.name) {
                    case "Золото с врага": _currentValue = global.gold_mod; break;
                    case "Бонус к опыту": _currentValue = global.xp_mod; break;
                    default: _currentValue = 0; break;
                }
                draw_text(_elementX + itemWidth / 2, _elementY + 35, "Тек: " + string(_currentValue));
                
                if (_item.currentLevel < _item.maxLevel) {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, string(_item.cost) + " $");
                } else {
                    draw_text(_elementX + itemWidth / 2, _elementY + 75, "МАКС");
                }
                
                if (sprite_exists(_item.sprite)) {
                    draw_sprite(_item.sprite, 0, _elementX + 20, _elementY + 45);
                }
            }
            else if (is_string(_item)) {
                draw_set_color(c_red);
                draw_text(_elementX + itemWidth / 2, _elementY + itemHeight / 2, _item);
            }
        }
        break;
}

// Сброс настроек рисования
draw_set_halign(fa_left);
draw_set_color(c_white);