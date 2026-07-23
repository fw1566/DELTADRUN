//freeze during fade
if(instance_exists(obj_fade)){
	image_speed = 0
	exit
}

if(!instance_exists(obj_player)){
	exit
}

//follow susies path
var prev_x = x
var prev_y = y

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

//copy susies walk frame from the same path point
image_speed = 0
if(x != prev_x or y != prev_y){
	image_index = obj_player.follow_img[target]
} else{
	//standing: match whatever susie last left on the path
	var img = obj_player.follow_img[target]
	var foot = floor(img)
	if(foot == 1 or foot == 3){
		image_index = img
	} else{
		image_index = 0
	}
}

//dont shake
x = round(x)
y = round(y)

//draw order by y
depth = -bbox_bottom
