if (instance_exists(obj_tower)) {
    var target_x = obj_tower.x;
    var target_y = obj_tower.y;
    
    // Вычисляем расстояние до цели
    var distance_to_target = point_distance(x, y, target_x, target_y);
    
    // Если расстояние больше 100, двигаемся к цели
    if (distance_to_target > 100) {
        move_towards_point(target_x, target_y, move_speed);
    } else {
        // Останавливаемся, если находимся в радиусе 100 пикселей
        speed = 0;
        
        // Дополнительно: можно добавить атаку или другую логику здесь
        // Например, начать атаковать башню
    }
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