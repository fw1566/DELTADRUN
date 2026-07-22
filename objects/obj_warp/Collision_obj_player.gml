//start fade and teleport
if(!instance_exists(obj_fade) and target_room != noone){
	var f = instance_create_depth(0, 0, 0, obj_fade)
	f.fade_out = true
	f.target_room = target_room
	f.target_x = target_x
	f.target_y = target_y
}
