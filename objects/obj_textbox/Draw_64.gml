//draw the textbox on the gui layer so it always sits flat on the screen, deltarune style
//(the gui was locked to the room's native resolution in Create_0, so these coordinates
//are plain room pixels, same scale as the rest of the game's pixel art)

var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()

var box_x = (gui_w - box_w) / 2
var box_y = gui_h - box_h - box_margin_edge
if(box_at_top){
	box_y = box_margin_edge
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
