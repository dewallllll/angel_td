if (instance_exists(target))
{
	
}
else {
instance_destroy()	
}
// Проверка инициализации переменных
if (!variable_instance_exists(id, "cur_bounce_count")) {
    cur_bounce_count = 0;
}
if (!variable_instance_exists(id, "bounce_chance")) {
    bounce_chance = global.bounce_shot_chance;
}