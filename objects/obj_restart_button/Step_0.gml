// Step Event кнопки obj_restart_button
// Преобразуем координаты мыши в координаты GUI и проверяем, наведен ли курсор на кнопку
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
hovering = position_meeting(mx, my, id);

// Обработка нажатия и отпускания кнопки мыши
if (hovering && mouse_check_button_pressed(mb_left)) {
    clicked = true;
}

if (mouse_check_button_released(mb_left)) {
    if (hovering && clicked) {
        room_restart(); // Перезапустить комнату
    }
    clicked = false;
}
