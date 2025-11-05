// Находим ближайшего врага
target = instance_nearest(x, y, obj_tower);

// Если враг найден, рассчитываем направление и задаем скорость
if (instance_exists(target))
{
    direction = point_direction(x, y, target.x, target.y); // Направление к врагу
    image_angle = direction; // Поворачиваем спрайт пули
    speed = 3; // Скорость полета пули :cite[1]
	move_speed = 3;
}
else {
	instance_destroy()
}