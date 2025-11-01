
global.perk_list = ds_list_create();

var perk_multishot = ds_map_create();
ds_map_add(perk_multishot, "name", "Мультишот"); 
ds_map_add(perk_multishot, "rarity", 0); 
ds_map_add(perk_multishot, "base_weight", 100); 
ds_map_add(perk_multishot, "effect", "Шанс повторного выстрела по другому противнику"); 
ds_list_add(global.perk_list, perk_multishot); 

var perk_shot_count = ds_map_create();
ds_map_add(perk_shot_count, "name", "Кол-во выстрелов"); 
ds_map_add(perk_shot_count, "rarity", 0); 
ds_map_add(perk_shot_count, "base_weight", 100); 
ds_map_add(perk_shot_count, "effect", "Шанс повторного выстрела по тому же противнику"); 
ds_list_add(global.perk_list, perk_shot_count); 

