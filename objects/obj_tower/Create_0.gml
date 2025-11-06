alarm[0] = room_speed * 3;
global.can_take_damage = true;
global.damage_cooldown = 0

global.gold = 10000000000000
global.xp = 0
global.cur_tower_hp = 10
global.xp_to_up = 10
global.current_level = 1

// МАССИВ для хранения информации о навыках вместо ds_map
global.all_skills = [];

// СТАТЫ

global.max_tower_hp = 10
array_push(global.all_skills, {var_name: "max_tower_hp", display_name: "Максимальное здоровье"});

global.dmg = 5
array_push(global.all_skills, {var_name: "dmg", display_name: "Урон"});

global.crit_mod = 0.01
array_push(global.all_skills, {var_name: "crit_mod", display_name: "Шанс крита"});

global.crit_dmg_mod = 2
array_push(global.all_skills, {var_name: "crit_dmg_mod", display_name: "Урон крита"});

global.attack_speed = 1
array_push(global.all_skills, {var_name: "attack_speed", display_name: "Атак в секунду"});

global.hp_regen = 0
array_push(global.all_skills, {var_name: "hp_regen", display_name: "Регенерация"});

global.attack_radius = 300
array_push(global.all_skills, {var_name: "attack_radius", display_name: "Радиус атаки"});

global.tower_armor = 0
array_push(global.all_skills, {var_name: "tower_armor", display_name: "Броня"});

global.tower_armor_percent = 0
array_push(global.all_skills, {var_name: "tower_armor_percent", display_name: "Снижение урона %"});

global.tower_thorns_damage = 0
array_push(global.all_skills, {var_name: "tower_thorns_damage", display_name: "Урон шипов"});

global.life_stealing = 0
array_push(global.all_skills, {var_name: "life_stealing", display_name: "Вампиризм"});

global.xp_mod = 1
array_push(global.all_skills, {var_name: "xp_mod", display_name: "Множитель опыта"});

global.gold_mod = 1
array_push(global.all_skills, {var_name: "gold_mod", display_name: "Множитель золота"});

global.shot_count = 1
array_push(global.all_skills, {var_name: "shot_count", display_name: "Кол-во выстрелов"});

global.shot_count_chance = 0
array_push(global.all_skills, {var_name: "shot_count_chance", display_name: "Шанс на доп выстрелы"});

global.multishot_chance = 0
array_push(global.all_skills, {var_name: "multishot_chance", display_name: "Шанс на мультишот"});

global.multishot_count = 1
array_push(global.all_skills, {var_name: "multishot_count", display_name: "Кол-во мультишот пуль"});

global.bounce_shot_chance = 0
array_push(global.all_skills, {var_name: "bounce_shot_chance", display_name: "Шанс на отскок"});

global.bounce_shot_count = 0
array_push(global.all_skills, {var_name: "bounce_shot_count", display_name: "Кол-во отскоков"});

global.UI_Layer = layer_create(100, "UI");
global.enemy_speed_mult = 1
global.pause = false
can_heal = true
heal_cooldown = 0