//fade
if(fade_out){
	alpha += fade_spd
	if(alpha >= 1){
		alpha = 1
		fade_out = false
		room_goto(target_room)
	}
} else{
	alpha -= fade_spd
	if(alpha <= 0){
		instance_destroy()
	}
}
