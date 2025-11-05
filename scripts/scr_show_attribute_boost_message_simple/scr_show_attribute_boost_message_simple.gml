// Упрощенная функция показа сообщения
function show_attribute_boost_message_simple(attribute_name, old_value, new_value) {
    // Просто выводим сообщение в debug
    show_debug_message("=== УЛУЧШЕНИЕ АТРИБУТА ===");
    show_debug_message("Атрибут: " + attribute_name);
    show_debug_message("Значение: " + string(old_value) + " → " + string(new_value));
    show_debug_message("========================");
    
    // Звук улучшения (если есть)
    if (variable_global_exists("snd_attribute_boost") && audio_exists(snd_attribute_boost)) {
        audio_play_sound(snd_attribute_boost, 1, false);
    }
}