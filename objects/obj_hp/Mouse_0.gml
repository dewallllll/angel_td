if global.gold >= cost {
	global.gold -= cost
	cost = cost * 1.3
	global.max_tower_hp *= 1.2
}