//place player after room change
if(instance_exists(obj_player)){
	obj_player.x = target_x
	obj_player.y = target_y
	obj_player.image_index = 0
}
