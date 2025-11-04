// Событие Draw GUI объекта obj_message
draw_set_alpha(alpha_val); // Устанавливаем текущую прозрачность для рисования
draw_set_font(cs);
draw_set_color(c_red); // Устанавливаем цвет текста
draw_set_halign(fa_center); // Выравнивание по горизонтали по центру
draw_set_valign(fa_middle); // Выравнивание по вертикали по центру
// Рисуем текст в центре экрана
draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, message_text);