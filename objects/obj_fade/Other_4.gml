//place player after room change, keep sprite stood still
if(instance_exists(obj_player)){
	obj_player.x = target_x
	obj_player.y = target_y
	obj_player.image_speed = 0
	obj_player.image_index = 0

	if(target_sprite != -1){
		obj_player.sprite_index = target_sprite
	}
}
