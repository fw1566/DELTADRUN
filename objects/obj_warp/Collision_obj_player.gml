//start fade and teleport
//scr_world_frozen also covers an open dialogue, so susie can't get warped out
//of the room in the middle of someone's line
if(!scr_world_frozen() and target_room != noone){
	var f = instance_create_depth(0, 0, 0, obj_fade)
	f.fade_out = true
	f.target_room = target_room
	f.target_x = target_x
	f.target_y = target_y
	f.target_sprite = obj_player.sprite_index
}
