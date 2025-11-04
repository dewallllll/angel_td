// В Collision Event с пулей врага:
if (true) {
     hp -=  global.dmg
	 global.cur_tower_hp += global.dmg * global.life_stealing
	 show_debug_message("Урон нанесен, хп врага:" + string(hp))
    // Дополнительные эффекты: анимация, звук и т.д.
}
