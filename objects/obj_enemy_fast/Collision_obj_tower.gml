if (can_attack) {
    global.cur_tower_hp -= enemy_dmg; // Наносим урон
	hp -= global.tower_thorns_damage * global.max_tower_hp
    can_attack = false; // Запускаем кулдаун для этого конкретного врага
    attack_cooldown = room_speed; // Устанавливаем длительность кулдауна (1 секунда)
    
    // Здесь можно добавить визуальные эффекты, звук и отталкивание
}