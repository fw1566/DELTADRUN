//draw the textbox in room space, sized off the camera's current view -- this keeps the
//box the correct size relative to what's actually visible, even if the window's aspect
//ratio doesn't match the room and gamemaker adds black letterbox/pillarbox bars (the gui
//layer stretches across those bars too, which is what made the box look oversized before)

var cam = view_camera[0]
var cam_x = camera_get_view_x(cam)
var cam_y = camera_get_view_y(cam)
var cam_w = camera_get_view_width(cam)
var cam_h = camera_get_view_height(cam)

var box_w = cam_w - box_margin_side * 2
var box_h = round(cam_h * box_h_ratio)

var box_x = cam_x + (cam_w - box_w) / 2
var box_y = cam_y + cam_h - box_h - box_margin_edge
if(box_at_top){
	box_y = cam_y + box_margin_edge
}

//black box with a plain white border, no rounded corners, no portrait -- just like an overworld "check"
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false)

draw_set_color(c_white)
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true)
draw_rectangle(box_x + 1, box_y + 1, box_x + box_w - 1, box_y + box_h - 1, true)

//the text itself: fnt_main, white, left aligned, wrapped to the box width
draw_set_font(fnt_main)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

var text = pages[page]
var shown = string_copy(text, 1, char_i)
draw_text_ext(box_x + text_pad_x, box_y + text_pad_y, shown, 16, box_w - text_pad_x * 2)

draw_set_color(c_white)
