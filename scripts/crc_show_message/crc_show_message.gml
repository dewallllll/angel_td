// Функция показа сообщения
function showw_message(text) {
    // Пытаемся найти уже существующий объект сообщения
    var _msg_instance = instance_find(obj_message, 0);
    
    // Если такой объект уже есть, используем его
    if (instance_exists(_msg_instance)) {
		show_debug_message("Использован существующий объект для сообщений");
        with (_msg_instance) {
            message_text = text; // Обновляем текст
            alpha_val = 0; // Сбрасываем прозрачность
            state = "fade_in"; // Запускаем анимацию появления
            life_timer = room_speed * 2; // Сбрасываем таймер показа
        }
    } else {
        // Если объекта нет, создаем новый
		show_debug_message("Создан новый объект для сообщений");
        with (instance_create_layer(0, 0, "UI", obj_message)) {
            message_text = text;
        }
    }
}