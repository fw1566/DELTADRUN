//define variables
//textbox shown when susie checks a prop (pc, cage, etc), same feel as the deltarune overworld "check" box

pages = [""]		//array of pages of text, filled in by whoever creates the box (usually obj_prop)
page = 0			//current page index

//typewriter reveal
char_i = 0			//how many characters of the current page are shown
char_spd = 1		//characters revealed per step (matches overworld text speed)

//once the whole page is shown, wait for another Z press before advancing
page_done = false

//draw in normal room space (not the gui layer) so the box is sized against the camera's
//actual view, not the gui layer's size -- the gui layer stretches to the whole window,
//including any black letterbox/pillarbox bars added to keep the room's aspect ratio,
//which made a box sized off display_get_gui_width/height noticeably oversized
depth = -100000		//always draw on top of the room

//box layout, measured off an actual deltarune screenshot: the box sits close to the edge
//of the screen (a small ~5px gap at native res) but leaves a wider ~16px gap on the sides
box_margin_side = 16
box_margin_edge = 5
box_h_ratio = 0.3125		//box height as a fraction of the camera's view height

//text draw padding inside the box
text_pad_x = 10
text_pad_y = 10

//deltarune moves the box to whichever half of the screen susie ISN'T standing in,
//so she's never hidden behind her own dialogue
box_at_top = false
if(instance_exists(obj_player)){
	var cam = view_camera[0]
	var cam_y = camera_get_view_y(cam)
	var cam_h = camera_get_view_height(cam)
	var player_screen_y = obj_player.y - cam_y
	
	//susie in the top half of the screen -> box goes on the bottom, and vice versa
	box_at_top = (player_screen_y < cam_h / 2)
}
