if (!visible) exit;

var screen_width = display_get_width();
var screen_height = display_get_height();

// Полупрозрачный фон
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, screen_width, screen_height, false);
draw_set_alpha(1);

// Заголовок
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(screen_width / 2, 100, "ВЫБЕРИТЕ УСИЛЕНИЕ");

// Отрисовываем карточки
for (var i = 0; i < array_length(perks); i++) {
    var _perk = perks[i];
    if (is_undefined(_perk)) continue;
    
    var card_x = start_x + i * (card_width + card_spacing);
    var card_y = (screen_height - card_height) / 2;
    
    // Фон карточки
    var bg_color = c_gray;
    switch (_perk[? "rarity"]) {
        case 1: bg_color = c_blue; break;
        case 2: bg_color = c_purple; break;
    }
    
    draw_set_color(bg_color);
    draw_rectangle(card_x, card_y, card_x + card_width, card_y + card_height, false);
    
    // Рамка
    draw_set_color(c_white);
    draw_rectangle(card_x, card_y, card_x + card_width, card_y + card_height, true);
    
    // Текст
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(card_x + card_width / 2, card_y + 30, _perk[? "name"]);
    draw_text(card_x + card_width / 2, card_y + 60, _perk[? "effect"]);
	
	// В Draw Event obj_perk_popup, внутри цикла отрисовки карточек:

	// После отрисовки названия перка добавляем уровень:
	var _perk_name = _perk[? "name"];
	var _current_level = 0;
	if (ds_map_exists(global.perk_levels, _perk_name)) {
	    _current_level = global.perk_levels[? _perk_name];
	}
	var _max_level = _perk[? "max_level"];

	// Отображаем уровень перка
	draw_set_color(c_yellow);
	draw_text(card_x + card_width / 2, card_y + 45, "Уровень " + string(_current_level) + "/" + string(_max_level));
	draw_set_color(c_white);
    
    // ===== ВИЗУАЛЬНАЯ ОТЛАДКА =====
    // Показываем зону клика красной рамкой
    // draw_set_color(c_red);
    //draw_rectangle(card_x, card_y, card_x + card_width, card_y + card_height, true);
    
    // Номер карточки
   // draw_text(card_x + 10, card_y + 10, "Card " + string(i));
}

// Координаты мыши для отладки
//draw_set_halign(fa_left);
//draw_text(10, 10, "Mouse: " + string(device_mouse_x_to_gui(0)) + ", " + string(device_mouse_y_to_gui(0)));
//draw_text(10, 30, "Active: " + string(is_active));
//draw_text(10, 50, "Perks: " + string(array_length(perks)));

// Инструкция
draw_set_halign(fa_center);
draw_text(screen_width / 2, screen_height - 50, "Нажми на карточку для выбора");
draw_set_halign(fa_left);