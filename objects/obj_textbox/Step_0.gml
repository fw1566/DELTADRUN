//advance the typewriter, listen for the confirm key (Z), same as the original overworld text

//the box only really goes away at the start of the next frame, so for the rest of the
//frame that closed it everything else still counts the world as frozen -- otherwise the
//very same Z press could be picked up by obj_prop and instantly reopen the box
if(closing){
	instance_destroy()
	exit
}

//pages are filled in right after we're created, so the wrapping waits until the first step
scr_textbox_prepare()

var confirm = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter)
var text = screens[screen]

if(!page_done){
	//reveal one more character and play the typewriter blip
	if(char_i < string_length(text)){
		char_i += char_spd
		if(char_i > string_length(text)){
			char_i = string_length(text)
		}
		
		//line breaks cost no time, the next line starts typing on the same frame
		while(char_i < string_length(text) and string_char_at(text, char_i + 1) == "\n"){
			char_i += 1
		}
		
		//blip for every printed character, skipping spaces like the original text sound
		var shown_char = string_char_at(text, min(char_i, string_length(text)))
		if(shown_char != " " and shown_char != "\n"){
			audio_play_sound(snd_text, 10, false)
		}
	} else{
		page_done = true
	}
	
	//pressing Z while typing instantly fills the current page
	if(confirm){
		char_i = string_length(text)
		page_done = true
	}
} else{
	//page is fully shown, Z either turns the page or closes the box
	if(confirm){
		screen += 1
		if(screen >= array_length(screens)){
			closing = true
		} else{
			char_i = 0
			page_done = false
		}
	}
}
