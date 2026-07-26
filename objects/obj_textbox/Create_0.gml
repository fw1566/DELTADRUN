//define variables

//the message, one entry per "page", filled in by whoever creates us
//e.g. t.pages = string_split("* Первая.|* Вторая.", "|")
pages = [""]

//the pages after word wrapping, one entry per boxful of text (up to 3 lines),
//lines inside one entry are separated with "\n"
screens = [""]
screen = 0

//does the screen with this index open with the deltarune "*"?
screen_star = [false]

//wrapping needs pages, and pages get set right after we are created, so it can't
//happen here -- the draw event does it on the first frame and flips this to true
screens_ready = false

//typewriter reveal
char_i = 0
char_spd = 1

page_done = false

//set on the frame the last page is confirmed, the box then closes one frame later
//so the Z press that dismissed it can't also trigger whatever is standing nearby
closing = false

depth = -100000


//box geometry, in room pixels
//deltarune runs at 640x480 and this game runs at 320x240, so every original
//measurement is just halved -- the comment keeps the original number
box_w = 288				//576, leaves 16px of the view free on both sides
box_h = 75				//150
box_edge_gap = 5		//10, gap between the box and the edge of the view
box_border = 3			//6, thickness of the white frame


//text layout, measured from the top left corner of the box
star_x = 13				//26, the "*" that opens a line of dialogue
text_x = 29				//58, the text column, wrapped lines line up with it too
text_y = 11				//22, top of the first line
text_pad_right = 29		//58, mirrors the text column so the text block sits centered
line_h = 18				//36, distance from one line of text to the next
lines_per_screen = 3	//the original never shows more than three lines at once


//the box jumps to the top of the screen when susie stands in the lower half,
//so she is never covered by her own dialogue
box_at_top = false
if(instance_exists(obj_player)){
	var cam = view_camera[0]
	var cam_y = camera_get_view_y(cam)
	var cam_h = camera_get_view_height(cam)
	var player_screen_y = obj_player.y - cam_y
	box_at_top = (player_screen_y < cam_h / 2)
}
