speed = move_speed * global.enemy_speed_mult
if (instance_exists(obj_tower)) { // Всегда проверяйте, существует ли цель
    var target_x = obj_tower.x;
    var target_y = obj_tower.y;
    move_towards_point(target_x, target_y, move_speed); // 3 - скорость движения
}

if (!can_attack) {
    attack_cooldown -= 1;
    if (attack_cooldown <= 0) {
        can_attack = true;
    }
}

if (hp<=0) {
	instance_destroy()
	global.gold += 1 * (global.difficult_manager + global.gold_mod)
	global.xp += 1 * (global.difficult_manager + global.xp_mod)
}

if global.pause == true {
	speed = 0
}

if global.pause == false {
	speed = move_speed * global.enemy_speed_mult
}
