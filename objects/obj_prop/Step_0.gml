//check for susie interacting with this prop (pc, cage, etc), same feel as deltarune's "check"

//only one textbox and one fade at a time, and don't check while mid-transition --
//without this the same Z press that closes a box would immediately reopen it
if(!instance_exists(obj_player) or scr_world_frozen()){
	exit
}

//is susie standing close enough and facing this prop?
var near_x = abs(obj_player.x - x) <= (bbox_right - bbox_left) / 2 + check_reach
var near_y = abs(obj_player.y - y) <= (bbox_bottom - bbox_top) / 2 + check_reach

if(near_x and near_y and keyboard_check_pressed(ord("Z"))){
	//figure out which side of the prop susie needs to be facing to check it
	var dx = x - obj_player.x
	var dy = y - obj_player.y
	var facing_right = (obj_player.sprite_index == spr_susiewr)
	var facing_left = (obj_player.sprite_index == spr_susiewl)
	var facing_up = (obj_player.sprite_index == spr_susiewu)
	var facing_down = (obj_player.sprite_index == spr_susiewd)
	
	var facing_prop = false
	if(abs(dx) >= abs(dy)){
		//prop is mostly to the left/right of susie
		facing_prop = (dx > 0 and facing_right) or (dx < 0 and facing_left)
	} else{
		//prop is mostly above/below susie
		facing_prop = (dy > 0 and facing_down) or (dy < 0 and facing_up)
	}
	
	if(facing_prop){
		//open the description box, same font/sound as the rest of the game
		var t = instance_create_depth(0, 0, 0, obj_textbox)
		t.pages = string_split(check_text, "|")
	}
}
