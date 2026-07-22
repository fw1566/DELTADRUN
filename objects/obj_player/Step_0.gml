//freeze during fade
if(instance_exists(obj_fade)){
	image_speed = 0
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

if(xspd != 0 or yspd != 0){
	image_speed = 1
} else{
    image_speed = 0
	image_index = 0
}

//dont shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])