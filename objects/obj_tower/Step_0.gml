var cur_room_speed = room_speed
if global.pause = true {
	global.enemy_speed_mult = 0
}
if global.pause = false {
	global.enemy_speed_mult = 1
}
if (global.cur_tower_hp <= 0) {
	pause = true; // Останавливаем игровые процессы
	instance_destroy(all)
    if (!instance_exists(obj_restart_button)) { // Чтобы кнопка не создавалась многократно
        instance_create_layer(950, 540, "Instances", obj_restart_button);
    }
}

if (!can_heal) {
    heal_cooldown -= 1;
    if (heal_cooldown <= 0) {
        can_heal = true;
    }
}
if (can_heal) {
if global.cur_tower_hp < global.max_tower_hp {
	if global.cur_tower_hp + global.hp_regen >=  global.max_tower_hp {
		global.cur_tower_hp = global.max_tower_hp
	}
	else {
		global.cur_tower_hp += global.hp_regen
	}
}
 can_heal = false;
 heal_cooldown = room_speed;
}

//левел апы
if global.xp >= global.xp_to_up {
	with (obj_perk_popup) {
		show_perk_popup();
	}
	global.current_level += 1
	global.xp_to_up += global.xp_to_up * 2
	global.xp = 0
	showw_message("Уровень повышен до " + string(global.current_level))
	global.max_tower_hp += 1
	global.dmg *= 1.2
	if global.attack_speed >=0.19 {
	global.attack_speed -= 0.1;
	}
	global.crit_mod += 0.01;
	global.crit_dmg_mod *= 1.3;
	global.hp_regen *= 1.3;
	global.tower_armor += 1;
	global.tower_armor_percent += 0.01;
	global.tower_thorns_damage += 0.01;
}