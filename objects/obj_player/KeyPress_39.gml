//freeze during fade
if(instance_exists(obj_fade)){
	exit
}

//face direction when standing
if(xspd == 0 and yspd == 0){
	sprite_index = spr_susiewr
}
