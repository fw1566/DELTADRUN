//define variables

pages = [""]		
page = 0			

//typewriter reveal
char_i = 0			
char_spd = 1		


page_done = false

depth = -100000


box_margin_side = 16
box_margin_edge = 5
box_h_ratio = 0.3125		


text_pad_x = 10
text_pad_y = 10


box_at_top = false
if(instance_exists(obj_player)){
	var cam = view_camera[0]
	var cam_y = camera_get_view_y(cam)
	var cam_h = camera_get_view_height(cam)
	var player_screen_y = obj_player.y - cam_y
	box_at_top = (player_screen_y < cam_h / 2)
}
