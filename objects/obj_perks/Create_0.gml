global.perk_levels = ds_map_create();
global.perk_dependencies = ds_map_create();

// Функция проверки, что все перки (кроме самого "Улучшить случайный атрибут") максимальны
global.perk_all_max_requirement = function() {
    if (!variable_global_exists("perk_list") || !variable_global_exists("perk_levels")) {
        return false;
    }
    
    var all_maxed = true;
    
    for (var i = 0; i < ds_list_size(global.perk_list); i++) {
        var perk = global.perk_list[| i];
        
        // Пропускаем некорректные перки
        if (is_undefined(perk) || !ds_exists(perk, ds_type_map)) {
            continue;
        }
        
        var perk_name = perk[? "name"];
        if (is_undefined(perk_name) || perk_name == "") {
            continue;
        }
        
        // Пропускаем сам перк "Улучшить случайный атрибут"
        if (perk_name == "Улучшить случайный атрибут") {
            continue;
        }
        
        var max_level = perk[? "max_level"];
        var current_level = 0;
        
        // Получаем текущий уровень перка
        if (ds_map_exists(global.perk_levels, perk_name)) {
            current_level = global.perk_levels[? perk_name];
        }
        
        // Проверяем зависимости (если есть)
        var requirement = perk[? "requirement"];
        var requirement_met = true;
        
        if (!is_undefined(requirement) && requirement != undefined) {
            try {
                requirement_met = requirement();
            } catch (e) {
                requirement_met = false;
            }
        }
        
        // Если перк не достиг максимума ИЛИ его зависимости не выполнены - он не максимален
        if ((max_level > 0 && current_level < max_level) || !requirement_met) {
            all_maxed = false;
            break;
        }
    }
    
    show_debug_message("Все перки максимальны: " + string(all_maxed));
    return all_maxed;
};

global.perk_multishot_requirement = function() {
    return global.perk_levels[? "Шанс мультишота"] >= 1;
};
global.perk_shot_count_requirement = function() {
    return global.perk_levels[? "Шанс повторного выстрела"] >= 1;
};
global.perk_bounceshot_requirement = function() {
    return global.perk_levels[? "Шанс отскока"] >= 1;
};

global.perk_list = ds_list_create();

var perk_multishot = ds_map_create();
ds_map_add(perk_multishot, "name", "Шанс мультишота"); 
ds_map_add(perk_multishot, "rarity", 0); 
ds_map_add(perk_multishot, "base_weight", 80); 
ds_map_add(perk_multishot, "effect", "Шанс повторного выстрела по другому противнику"); 
ds_map_add(perk_multishot, "max_level", 8); // Максимум 5 уровней
ds_map_add(perk_multishot, "requirement", undefined); // Нет требований
ds_map_add(perk_multishot, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_multishot);

var perk_multishot_count = ds_map_create();
ds_map_add(perk_multishot, "name", "Кол-во мультишота"); 
ds_map_add(perk_multishot, "rarity", 2); 
ds_map_add(perk_multishot, "base_weight", 40); 
ds_map_add(perk_multishot, "effect", "Кол-во выстрелов мультишота"); 
ds_map_add(perk_multishot_count, "max_level", 10); // Максимум 5 уровней
ds_map_add(perk_multishot_count, "requirement", global.perk_multishot_requirement); // Нет требований
ds_map_add(perk_multishot_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_multishot_count);

var perk_shot_count_chance = ds_map_create();
ds_map_add(perk_shot_count_chance, "name", "Шанс повторного выстрела"); 
ds_map_add(perk_shot_count_chance, "rarity", 0); 
ds_map_add(perk_shot_count_chance, "base_weight", 80); 
ds_map_add(perk_shot_count_chance, "effect", "Кол-во повторного выстрела по тому же противнику"); 
ds_map_add(perk_shot_count_chance, "max_level", 10); // Максимум 5 уровней
ds_map_add(perk_shot_count_chance, "requirement", undefined); // Нет требований
ds_map_add(perk_shot_count_chance, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_shot_count_chance);

var perk_shot_count = ds_map_create();
ds_map_add(perk_shot_count, "name", "Кол-во выстрелов"); 
ds_map_add(perk_shot_count, "rarity", 0); 
ds_map_add(perk_shot_count, "base_weight", 80); 
ds_map_add(perk_shot_count, "effect", "Кол-во повторного выстрела по тому же противнику"); 
ds_map_add(perk_shot_count, "max_level", 10); // Максимум 5 уровней
ds_map_add(perk_shot_count, "requirement", global.perk_shot_count_requirement); // Нет требований
ds_map_add(perk_shot_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_shot_count); 

var perk_bounce_chance = ds_map_create();
ds_map_add(perk_bounce_chance, "name", "Шанс отскока"); 
ds_map_add(perk_bounce_chance, "rarity", 1); 
ds_map_add(perk_bounce_chance, "base_weight", 60); 
ds_map_add(perk_bounce_chance, "effect", "Шанс отскока выстрела в другого противника"); 
ds_map_add(perk_bounce_chance, "max_level", 10); // Максимум 5 уровней
ds_map_add(perk_bounce_chance, "requirement", undefined); // Нет требований
ds_map_add(perk_bounce_chance, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_bounce_chance); 

var perk_bounce_count = ds_map_create();
ds_map_add(perk_bounce_count, "name", "Кол-во отскоков"); 
ds_map_add(perk_bounce_count, "rarity", 2); 
ds_map_add(perk_bounce_count, "base_weight", 40); 
ds_map_add(perk_bounce_count, "effect", "Кол-во отскока выстрела в другого противника"); 
ds_map_add(perk_bounce_count, "max_level", 10); // Максимум 5 уровней
ds_map_add(perk_bounce_count, "requirement", global.perk_bounceshot_requirement); // Нет требований
ds_map_add(perk_bounce_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_bounce_count); 

// ===== ПЕРК: УЛУЧШИТЬ СЛУЧАЙНЫЙ АТРИБУТ =====
var perk_random_boost = ds_map_create();
ds_map_add(perk_random_boost, "name", "Улучшить случайный атрибут");
ds_map_add(perk_random_boost, "rarity", 3); // Очень редкий
ds_map_add(perk_random_boost, "base_weight", 100); // Высокий вес, но появляется только когда другие перки максимальны
ds_map_add(perk_random_boost, "effect", "Увеличивает случайный атрибут на 50%");
ds_map_add(perk_random_boost, "max_level", 999); // Можно брать много раз
ds_map_add(perk_random_boost, "requirement", global.perk_all_max_requirement); // Требует максимальной прокачки всех перков
ds_map_add(perk_random_boost, "sprite", Sprite5); // Используем существующий спрайт или создаем новый
ds_list_add(global.perk_list, perk_random_boost);

