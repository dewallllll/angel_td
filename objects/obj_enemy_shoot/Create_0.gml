image_xscale = 1; 
image_yscale = 1; 
scale = 1.0
hp = 6 * global.difficult_manager
move_speed = 1
enemy_clear_damage = 2 * global.difficult_manager - global.tower_armor
if (enemy_clear_damage - (enemy_clear_damage * global.tower_armor_percent) > 0) {
	global.enemy_shoot_dmg = enemy_clear_damage - (enemy_clear_damage * global.tower_armor_percent)
}
else {
	global.enemy_shoot_dmg  = 0
}
can_attack = false
attack_cooldown = 0
alarm[0] = room_speed * 2; 