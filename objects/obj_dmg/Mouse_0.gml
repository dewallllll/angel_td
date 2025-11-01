if global.gold >= cost {
	global.gold -= cost
	cost = cost * 1.3
	global.dmg *= 1.2
}