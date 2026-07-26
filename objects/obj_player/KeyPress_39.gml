//freeze during a fade or while a dialogue is open -- susie shouldn't even turn
//to face a new direction while she's being talked at
if(scr_world_frozen()){
	exit
}

//face direction when standing
if(xspd == 0 and yspd == 0){
	sprite_index = spr_susiewr
}
