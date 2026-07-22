//place player after room change
if(instance_exists(obj_player)){
	obj_player.x = target_x
	obj_player.y = target_y
	obj_player.image_index = 0

	//face warp direction
	if(target_sprite != -1){
		obj_player.sprite_index = target_sprite
	}
}
