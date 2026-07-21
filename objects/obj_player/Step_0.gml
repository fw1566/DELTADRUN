//controls
var up_key = keyboard_check(vk_up)
var down_key = keyboard_check(vk_down)
var left_key = keyboard_check(vk_left)
var right_key = keyboard_check(vk_right)

//move
if(keyboard_check(vk_shift) or (ord("X"))){
	move_spd = run_spd
} else{
	move_spd = walk_spd
}

xspd = (right_key - left_key) * move_spd
yspd = (down_key - up_key) * move_spd

x += xspd
y += yspd

//animate
if(xspd > 0){
	sprite_index = spr_susiewr
} else if (xspd < 0){
	sprite_index = spr_susiewl
} else if (yspd > 0){
	sprite_index = spr_susiewd
} else if (yspd < 0){
	sprite_index = spr_susiewu
}

if(xspd != 0 or yspd != 0){
	image_speed = 1
} else{
    image_speed = 0
	image_index = 0
}