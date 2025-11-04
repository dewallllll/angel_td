
function scr_ApplyUpgrade(item) {
	show_debug_message(">>> Функция scr_ApplyUpgrade вызвана для: " + string(item.name));
	
    // Проверяем, можно ли улучшить дальше
    if (item.currentLevel >= item.maxLevel) {
        showw_message("Достигнут максимальный уровень!");
        return;
    }
    
    // Проверяем достаточно ли денег
    if (global.gold >= item.cost) {
        // Списываем деньги и повышаем уровень
        global.gold -= item.cost;
        item.currentLevel += 1;
        
        // Увеличиваем стоимость следующего уровня
        item.cost = round(item.cost * 1.5);
	
            switch (item.name) {
            case "ХП":
				if (global.cur_tower_hp = global.cur_tower_hp) {
					global.cur_tower_hp +=1
				}
                global.max_tower_hp += 1;
		
                break;
            case "Урон":
                global.dmg *= 1.2;
                break;
            case "Скорость атаки":
                global.attack_speed = (global.attack_speed*100/1.1)/100;
                break;
			case "Шанс крита":
                global.crit_mod += 0.01;
                break;
			case "Урон крита":
                global.crit_dmg_mod *= 1.3;
                break;
			case "Реген":
				if  global.hp_regen == 0 {
					global.hp_regen += 1;
					break;
				}
                global.hp_regen *= 1.3;
                break;
			case "Броня":
				if  global.hp_regen == 0 {
					global.hp_regen += 1;
					break;
				}
                global.tower_armor *= 1.3;
                break;
			case "Процент брони":
                global.tower_armor_percent += 0.01;
                break;
			case "Шипы":
                global.tower_thorns_damage += 0.01;
                break;
			case "Вампиризм":
                global.life_stealing += 0.01;
                break;
			case "Золото с врага":
                global.gold_mod += 0.01;
                break;
			case "Бонус к опыту":
                global.xp_mod += 0.01;
                break;
			case "Радиус атаки":
                global.attack_radius += 10;
                break;

        }
        // Воспроизводим звук улучшения
        // audio_play_sound(snd_upgrade, 1, false);
    } else {
        showw_message("Недостаточно денег!");
    }
}