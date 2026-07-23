//place player after room change, keep sprite stood still
if(instance_exists(obj_player)){
	obj_player.x = target_x
	obj_player.y = target_y
	obj_player.image_speed = 0
	obj_player.image_index = 0
	obj_player.walk_cycle = 0
	obj_player.step_i = -1
	obj_player.was_moving = false

	if(target_sprite != -1){
		obj_player.sprite_index = target_sprite
	}
	
	//reset party follow path behind facing
	with(obj_player){
		var trail_dx = 0
		var trail_dy = -1
		var face = 0
		if(sprite_index == spr_susiewr){
			trail_dx = -1
			trail_dy = 0
			face = 1
		} else if(sprite_index == spr_susiewl){
			trail_dx = 1
			trail_dy = 0
			face = 3
		} else if(sprite_index == spr_susiewu){
			trail_dx = 0
			trail_dy = 1
			face = 2
		}
		
		for(var i = 0; i < follow_points; i++){
			follow_x[i] = x + trail_dx * i * follow_space
			follow_y[i] = y + trail_dy * i * follow_space
			follow_face[i] = face
			follow_img[i] = 0
		}
	}
}

//place kris behind the player
if(instance_exists(obj_kris) and instance_exists(obj_player)){
	obj_kris.x = obj_player.follow_x[obj_kris.target]
	obj_kris.y = obj_player.follow_y[obj_kris.target]
	obj_kris.image_speed = 0
	obj_kris.image_index = 0
	
	var face = obj_player.follow_face[obj_kris.target]
	if(face == 1){
		obj_kris.sprite_index = obj_kris.spr_r
	} else if(face == 2){
		obj_kris.sprite_index = obj_kris.spr_u
	} else if(face == 3){
		obj_kris.sprite_index = obj_kris.spr_l
	} else{
		obj_kris.sprite_index = obj_kris.spr_d
	}
}
