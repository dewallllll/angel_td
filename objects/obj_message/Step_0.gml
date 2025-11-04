// Событие Step объекта obj_message
if (state == "fade_in") {
    alpha_val += fade_speed; // Постепенно увеличиваем прозрачность
    if (alpha_val >= 1) {
        alpha_val = 1; // Фиксируем максимальную непрозрачность
        state = "hold"; // Меняем состояние на "показ"
    }
} else if (state == "hold") {
    // Отсчитываем время показа
    life_timer -= 1;
    if (life_timer <= 0) {
        state = "fade_out"; // Меняем состояние на "исчезновение"
    }
} else if (state == "fade_out") {
    alpha_val -= fade_speed; // Постепенно уменьшаем прозрачность
    if (alpha_val <= 0) {
        instance_destroy(); // Сообщение полностью исчезло - уничтожаем объект
    }
}
// Применяем вычисленную прозрачность к спрайту
image_alpha = alpha_val;