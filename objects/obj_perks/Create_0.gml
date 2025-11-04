
global.perk_list = ds_list_create();

var perk_multishot = ds_map_create();
ds_map_add(perk_multishot, "name", "Шанс мультишота"); 
ds_map_add(perk_multishot, "rarity", 0); 
ds_map_add(perk_multishot, "base_weight", 80); 
ds_map_add(perk_multishot, "effect", "Шанс повторного выстрела по другому противнику"); 
ds_map_add(perk_multishot, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_multishot);

var perk_multishot_count = ds_map_create();
ds_map_add(perk_multishot, "name", "Кол-во мультишота"); 
ds_map_add(perk_multishot, "rarity", 2); 
ds_map_add(perk_multishot, "base_weight", 40); 
ds_map_add(perk_multishot, "effect", "Кол-во выстрелов мультишота"); 
ds_map_add(perk_multishot_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_multishot);

var perk_shot_count = ds_map_create();
ds_map_add(perk_shot_count, "name", "Кол-во выстрелов"); 
ds_map_add(perk_shot_count, "rarity", 0); 
ds_map_add(perk_shot_count, "base_weight", 80); 
ds_map_add(perk_shot_count, "effect", "Шанс повторного выстрела по тому же противнику"); 
ds_map_add(perk_shot_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_shot_count); 

var perk_bounce_chance = ds_map_create();
ds_map_add(perk_bounce_chance, "name", "Шанс отскока"); 
ds_map_add(perk_bounce_chance, "rarity", 1); 
ds_map_add(perk_bounce_chance, "base_weight", 60); 
ds_map_add(perk_bounce_chance, "effect", "Шанс отскока выстрела в другого противника"); 
ds_map_add(perk_bounce_chance, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_bounce_chance); 

var perk_bounce_count = ds_map_create();
ds_map_add(perk_bounce_count, "name", "Кол-во отскоков"); 
ds_map_add(perk_bounce_count, "rarity", 2); 
ds_map_add(perk_bounce_count, "base_weight", 40); 
ds_map_add(perk_bounce_count, "effect", "Шанс отскока выстрела в другого противника"); 
ds_map_add(perk_bounce_count, "sprite", Sprite5); // Добавляем спрайт иконки
ds_list_add(global.perk_list, perk_bounce_count); 

