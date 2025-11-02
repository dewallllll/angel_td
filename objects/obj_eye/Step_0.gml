// Находим ближайшую цель
var nearest = instance_nearest(x, y, obj_enemy);

if (instance_exists(nearest)) {
	speed = 0.5;
    // Вычисляем направление к цели
    var dir_x = nearest.x - x;
    var dir_y = nearest.y - y;
    var dist = point_distance(x, y, nearest.x, nearest.y);
    
    // Нормализуем направление
    if (dist > 0) {
        dir_x /= dist;
        dir_y /= dist;
    }
    
    // Обновляем позицию с ограничением радиуса
    var new_x = x + dir_x * speed;
    var new_y = y + dir_y * speed;
    
    // Проверяем, не выходит ли новая позиция за радиус
    var dist_to_center = point_distance(center_x, center_y, new_x, new_y);
    if (dist_to_center <= radius) {
        xx = new_x;
        yy = new_y;
    } else {
        // Ограничиваем позицию границей радиуса
        var angle = point_direction(center_x, center_y, new_x, new_y);
        x = center_x + lengthdir_x(radius, angle);
        y = center_y + lengthdir_y(radius, angle);
    }
}
if (!instance_exists(nearest)) {
	speed = 0;
}