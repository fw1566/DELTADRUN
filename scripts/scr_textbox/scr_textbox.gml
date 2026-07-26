//textbox helpers
//kept in a script instead of a method variable on obj_textbox, so the function exists
//from the moment the game loads -- a method defined in Create can't be seen by any
//event that happens to run before Create finishes


//true while the player isn't in control: a room transition is playing, or a dialogue
//is open. susie and the party stand still and nothing can be interacted with until
//it's over, exactly like the overworld in the real game
function scr_world_frozen(){
	return instance_exists(obj_fade) or instance_exists(obj_textbox)
}


//cut one page of text into lines that fit the box, then group those lines into
//screens of up to lines_per_screen lines
//
//	_text			the page, may start with "*"
//	_wrap_w			how many pixels of text fit on one line
//	_lines_per		how many lines fit in the box at once
//	_font			the font the box draws with, needed to measure the text
//
//returns a struct: { screens : array of strings, star : bool }
//lines inside one screen are separated with "\n"
function scr_textbox_wrap(_text, _wrap_w, _lines_per, _font){
	//string_width has to measure with the font the box actually draws with
	draw_set_font(_font)
	
	//the "*" is drawn separately instead of typed out, that way wrapped lines can
	//line up under the first word rather than under the star
	var has_star = (string_char_at(_text, 1) == "*")
	if(has_star){
		_text = string_delete(_text, 1, 1)
		while(string_char_at(_text, 1) == " "){
			_text = string_delete(_text, 1, 1)
		}
	}
	
	//forced breaks first, then word wrap whatever is left of each piece
	//"&" and "\n" both force a new line, the same way "&" does in the original
	var lines = []
	var pieces = string_split(string_replace_all(_text, "\n", "&"), "&")
	
	for(var c = 0; c < array_length(pieces); c++){
		var words = string_split(pieces[c], " ")
		var line = ""
		
		for(var w = 0; w < array_length(words); w++){
			//gluing the split space back in front of the word keeps the double
			//spaces the original likes to put after a comma
			var test = words[w]
			if(w > 0){
				test = line + " " + words[w]
			}
			
			if(string_width(test) <= _wrap_w or line == ""){
				line = test
			} else{
				array_push(lines, line)
				line = words[w]
			}
		}
		
		array_push(lines, line)
	}
	
	//three lines per box, anything longer simply becomes the next box
	var screens = []
	var l = 0
	
	while(l < array_length(lines)){
		var block = ""
		for(var i = 0; i < _lines_per and l < array_length(lines); i++){
			if(i > 0){
				block += "\n"
			}
			block += lines[l]
			l++
		}
		
		array_push(screens, block)
	}
	
	return {
		screens : screens,
		star : has_star,
	}
}


//wrap every page of a textbox and store the result on it
//safe to call every frame, it only does the work once
function scr_textbox_prepare(){
	if(screens_ready){
		exit
	}
	screens_ready = true
	
	var wrap_w = box_w - text_x - text_pad_right
	
	screens = []
	screen_star = []
	
	for(var p = 0; p < array_length(pages); p++){
		var wrapped = scr_textbox_wrap(pages[p], wrap_w, lines_per_screen, fnt_main)
		
		for(var s = 0; s < array_length(wrapped.screens); s++){
			array_push(screens, wrapped.screens[s])
			array_push(screen_star, wrapped.star)
		}
	}
	
	//never leave the box with nothing to show
	if(array_length(screens) == 0){
		screens = [""]
		screen_star = [false]
	}
}
