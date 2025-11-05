speed *= global.enemy_speed_mult

if global.pause == true {
	speed = 0
}

if global.pause == false {
	speed = move_speed * global.enemy_speed_mult
}