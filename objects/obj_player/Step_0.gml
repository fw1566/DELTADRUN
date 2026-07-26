//freeze during a fade or while a dialogue is open -- susie stops on the spot and
//keeps facing the way she was, she doesn't even finish the step she was taking
if(scr_world_frozen()){
	xspd = 0
	yspd = 0
	move_spd = walk_spd
	image_speed = 0
	image_index = 0
	walk_cycle = 0
	step_i = -1
	was_moving = false
	exit
}

//controls
var up_key = keyboard_check(vk_up)
var down_key = keyboard_check(vk_down)
var left_key = keyboard_check(vk_left)
var right_key = keyboard_check(vk_right)

//move, hold X/Shift to run up to full speed
if(keyboard_check(vk_shift) or keyboard_check(ord("X"))){
	move_spd = min(move_spd + run_acc, run_spd)
} else{
	move_spd = walk_spd
}

xspd = (right_key - left_key) * move_spd
yspd = (down_key - up_key) * move_spd

//collision, bumping resets run speed

if(place_meeting(x + xspd, y, obj_collider)){
	
	xspd = 0
	move_spd = walk_spd
}
if(place_meeting(x, y + yspd, obj_collider)){
	
	yspd = 0
	move_spd = walk_spd
}


x += xspd
y += yspd

//animate, keep direction on diagonal
if(xspd != 0 and yspd == 0){
	if(xspd > 0){
		sprite_index = spr_susiewr
	} else{
		sprite_index = spr_susiewl
	}
} else if(xspd == 0 and yspd != 0){
	if(yspd > 0){
		sprite_index = spr_susiewd
	} else{
		sprite_index = spr_susiewu
	}
}

//walk anim
//0 idle, 1 left foot, 2 idle, 3 right foot
//each new press: left -> idle slide -> right -> idle slide
image_speed = 0
var moving = (xspd != 0 or yspd != 0)
var foot = floor(walk_cycle)
var on_foot = (foot == 1 or foot == 3)

if(moving){
	if(!was_moving){
		//new tap / start walking
		step_i += 1
		if(step_i > 3){
			step_i = 0
		}
		
		//0 left, 1 idle slide, 2 right, 3 idle slide
		if(step_i == 0){
			walk_cycle = 1
		} else if(step_i == 1){
			walk_cycle = 0
		} else if(step_i == 2){
			walk_cycle = 3
		} else{
			walk_cycle = 2
		}
	} else{
		//holding: full walk cycle
		walk_anim_spd = max(4, move_spd)
		walk_cycle += walk_anim_spd / 30
		if(walk_cycle >= 4){
			walk_cycle -= 4
		}
	}
	
	//idle slots of the strip still draw as stand
	foot = floor(walk_cycle)
	if(foot == 0 or foot == 2){
		image_index = 0
	} else{
		image_index = walk_cycle
	}
} else if(on_foot){
	//stopped on a raised foot: keep it a moment, then idle
	walk_cycle += walk_anim_spd / 30
	if(walk_cycle >= 4){
		walk_cycle -= 4
	}
	foot = floor(walk_cycle)
	if(foot == 1 or foot == 3){
		image_index = walk_cycle
	} else{
		image_index = 0
	}
} else{
	//standing idle at game start and between taps
	image_index = 0
}

was_moving = moving

//dont shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

//record path + facing + walk frame for party
if(x != xprevious or y != yprevious){
	var face = 0
	if(sprite_index == spr_susiewr){
		face = 1
	} else if(sprite_index == spr_susiewu){
		face = 2
	} else if(sprite_index == spr_susiewl){
		face = 3
	}
	
	for(var i = follow_points - 1; i > 0; i--){
		follow_x[i] = follow_x[i - 1]
		follow_y[i] = follow_y[i - 1]
		follow_face[i] = follow_face[i - 1]
		follow_img[i] = follow_img[i - 1]
	}
	follow_x[0] = x
	follow_y[0] = y
	follow_face[0] = face
	follow_img[0] = image_index
}

//draw order by y
depth = -bbox_bottom
