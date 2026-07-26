//draw the textbox in room space, positioned off the camera's current view -- this keeps the
//box where it belongs even if the window's aspect ratio doesn't match the room and gamemaker
//adds black letterbox/pillarbox bars (the gui layer stretches across those bars too, which is
//what made the box look oversized before)

//already dismissed and waiting to be destroyed next frame, so don't draw it again
if(closing){
	exit
}

//pages are filled in right after we're created, so the wrapping waits until the first draw
scr_textbox_prepare()

var cam = view_camera[0]
var cam_x = camera_get_view_x(cam)
var cam_y = camera_get_view_y(cam)
var cam_w = camera_get_view_width(cam)
var cam_h = camera_get_view_height(cam)

//the box is a fixed size, exactly like the original -- it never stretches with the view
var box_x = cam_x + round((cam_w - box_w) / 2)
var box_y = cam_y + cam_h - box_h - box_edge_gap
if(box_at_top){
	box_y = cam_y + box_edge_gap
}

//draw_rectangle includes both corners, so the far edge is one pixel back
var box_x2 = box_x + box_w - 1
var box_y2 = box_y + box_h - 1

//white frame with a black fill, no rounded corners and no portrait --
//the plain overworld box deltarune uses for "check" text and hometown npcs
draw_set_alpha(1)

draw_set_color(c_white)
draw_rectangle(box_x, box_y, box_x2, box_y2, false)

draw_set_color(c_black)
draw_rectangle(box_x + box_border, box_y + box_border, box_x2 - box_border, box_y2 - box_border, false)

//the text itself: fnt_main, white, left aligned, already wrapped by scr_textbox_prepare
draw_set_font(fnt_main)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)

var text = screens[screen]
var shown = string_copy(text, 1, char_i)

//the star sits in its own column and shows up with the very first character, so wrapped
//lines stay lined up under the text instead of under the star
if(screen_star[screen] and char_i > 0){
	draw_text(box_x + star_x, box_y + text_y, "*")
}

//one draw_text per line pins the spacing to exactly line_h, whatever the font's own
//line height happens to be
var lines = string_split(shown, "\n")
for(var i = 0; i < array_length(lines); i++){
	draw_text(box_x + text_x, box_y + text_y + i * line_h, lines[i])
}

draw_set_color(c_white)
