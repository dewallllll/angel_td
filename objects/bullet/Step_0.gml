if (instance_exists(target))
{
	
}
else {
instance_destroy()	
}

if lifetime<=0 {
	instance_destroy()
}

if (place_meeting(x,y,obj_enemy_parent)) {
	instance_destroy()
}