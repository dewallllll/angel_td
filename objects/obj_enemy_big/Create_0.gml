image_xscale = 1; 
image_yscale = 1; 
scale = 1.0
hp = 20 * global.difficult_manager
move_speed = 0.5 * global.enemy_speed_mult
enemy_clear_damage = 2 * global.difficult_manager - global.tower_armor
if (enemy_clear_damage - (enemy_clear_damage * global.tower_armor_percent) > 0) {
	enemy_dmg = enemy_clear_damage - (enemy_clear_damage * global.tower_armor_percent)
}
else {
	enemy_dmg = 0
}
can_attack = true
attack_cooldown = 0
alarm[0] = room_speed * 1; 