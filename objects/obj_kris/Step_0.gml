//freeze during fade
if(instance_exists(obj_fade)){
	image_speed = 0
	exit
}

if(!instance_exists(obj_player)){
	exit
}

//follow susies path
x = obj_player.follow_x[target]
y = obj_player.follow_y[target]

//face from the path
var face = obj_player.follow_face[target]
if(face == 1){
	sprite_index = spr_r
} else if(face == 2){
	sprite_index = spr_u
} else if(face == 3){
	sprite_index = spr_l
} else{
	sprite_index = spr_d
}

//only animate while susie is actually walking
//when she stands (or finishes a foot hold), kris is idle frame 0
image_speed = 0
if(obj_player.xspd != 0 or obj_player.yspd != 0){
	image_index = obj_player.follow_img[target]
} else{
	image_index = 0
}

//dont shake
x = round(x)
y = round(y)

//draw order by y
depth = -bbox_bottom
