if (instance_exists(target))
{
	
}
else {
instance_destroy()	
}

if lifetime<=0 {
	instance_destroy()
}




// Уменьшаем кулдаун урона каждый кадр
if (damage_cooldown > 0) {
    damage_cooldown--;
}
else {
    can_damage = true; // Разрешаем нанесение урона, когда кулдаун истек
}