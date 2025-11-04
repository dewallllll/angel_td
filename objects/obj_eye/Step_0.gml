// Находим ближайшую цель

if (instance_exists(global.cur_target)) {
	var nearest = global.cur_target
}
else {
	var nearest = instance_nearest(x, y, obj_enemy_parent);
}
if (instance_exists(nearest)) {
    // Вычисляем идеальную позицию на границе радиуса
    var target_angle = point_direction(center_x, center_y, nearest.x, nearest.y);
    var target_x = center_x + lengthdir_x(radius, target_angle);
    var target_y = center_y + lengthdir_y(radius, target_angle);
    
    // Плавно интерполируем к целевой позиции
    var smooth_speed = 0.1; // Скорость интерполяции (0-1)
    x = lerp(x, target_x, smooth_speed);
    y = lerp(y, target_y, smooth_speed);
} else {
    speed = 0;
}