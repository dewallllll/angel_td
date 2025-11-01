if global.attack_speed > 0.1 {
	if global.gold >= cost {
		global.gold -= cost
		cost = cost * 1.5
		global.attack_speed -= 0.05
	}
}
else {
	cost = "MAX"
}