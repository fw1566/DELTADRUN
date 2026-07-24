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

//mirror susies walk animation: same foot at same time
//idle -> left foot -> idle -> right foot, just like susie
image_speed = 0
image_index = obj_player.image_index

//dont shake
x = round(x)
y = round(y)

//draw order by y
depth = -bbox_bottom
