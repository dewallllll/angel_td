// Draw GUI Event кнопки obj_restart_button
image_xscale = 1.2
image_yscale = 1.2
draw_self(); // Нарисовать саму кнопку
draw_set_halign(fa_center); // Выравнивание по горизонтали по центру
draw_set_valign(fa_middle); // Выравнивание по вертикали по центру
draw_set_color(c_white); // Цвет текста
draw_text(980, 500, button_text); // Нарисовать текст