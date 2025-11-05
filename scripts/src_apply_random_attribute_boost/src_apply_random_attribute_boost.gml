function apply_random_attribute_boost() {
    show_debug_message("=== APPLY RANDOM ATTRIBUTE BOOST ===");
    
    // Создаем массив возможных атрибутов для улучшения
    var attributes = [];
    
    // Добавляем атрибуты в массив, если они существуют
    if (variable_global_exists("max_tower_hp")) {
        array_push(attributes, "max_tower_hp");
    }
    if (variable_global_exists("dmg")) {
        array_push(attributes, "dmg");
    }
    if (variable_global_exists("crit_dmg_mod")) {
        array_push(attributes, "crit_dmg_mod");
    }
    if (variable_global_exists("hp_regen")) {
        array_push(attributes, "hp_regen");
    }
    if (variable_global_exists("tower_armor")) {
        array_push(attributes, "tower_armor");
    }
    
    // Если нет доступных атрибутов, выходим
    if (array_length(attributes) == 0) {
        show_debug_message("ERROR: No attributes available for boosting");
        return;
    }
    
    // Выбираем случайный атрибут
    var random_index = irandom(array_length(attributes) - 1);
    var selected_attribute = attributes[random_index];
    
    // Сохраняем старые значения для сообщения
    var old_value = variable_global_get(selected_attribute);
    
    // Увеличиваем атрибут на 50%
    var new_value = old_value * 1.5;
    variable_global_set(selected_attribute, new_value);
    
    // Показываем сообщение о улучшении
    var attribute_names = ds_map_create();
    ds_map_add(attribute_names, "max_tower_hp", "Макс. HP башни");
    ds_map_add(attribute_names, "dmg", "Урон");
    ds_map_add(attribute_names, "crit_dmg_mod", "Критический урон");
    ds_map_add(attribute_names, "hp_regen", "Регенерация HP");
    ds_map_add(attribute_names, "tower_armor", "Броня башни");
    
    var attribute_name = attribute_names[? selected_attribute];
    if (is_undefined(attribute_name)) {
        attribute_name = selected_attribute;
    }
    
    ds_map_destroy(attribute_names);
    
    show_debug_message("Улучшен атрибут: " + attribute_name + " (" + string(old_value) + " → " + string(new_value) + ")");
    
    // Вызываем упрощенную функцию показа сообщения
    show_attribute_boost_message_simple(attribute_name, old_value, new_value);
}