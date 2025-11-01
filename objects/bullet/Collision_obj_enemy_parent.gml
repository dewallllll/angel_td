if (random(1) < global.bounce_shot_chance) {
    var _bulletType;
    // Определяем тип пули (обычная или крит)
    if (random(1) < global.crit_mod) {
        _bulletType = bullet_crit_multishot;
    } else {
        _bulletType = bullet_multishot;
    }
    
    // Создаем пулю со смещением
    var new_bullet = instance_create_layer(x, y, "Instances", _bulletType);
    
    // Настраиваем пулю через with
    with (new_bullet) {
        image_xscale = 0.3;
        image_yscale = 0.3;
        is_multishot = true;
    }
	
}
lifetime -= 10;