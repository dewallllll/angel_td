global.difficult_level += 1.0
alarm[1] = room_speed * 60; // Спавн раз в 3 секунды :cite[1]
showw_message("Сложность повышена")
if (global.enemy_chance>=50) {
	global.enemy_big_chance += 1
	global.enemy_shoot_chance += 1
	global.enemy_fast_chance +=1
	global.enemy_chance -= 3
}