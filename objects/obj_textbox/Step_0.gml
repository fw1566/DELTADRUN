//advance the typewriter, listen for the confirm key (Z), same as the original overworld text

var confirm = keyboard_check_pressed(ord("Z"))
var text = pages[page]

if(!page_done){
	//reveal one more character and play the typewriter blip
	if(char_i < string_length(text)){
		char_i += char_spd
		if(char_i > string_length(text)){
			char_i = string_length(text)
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
		page += 1
		if(page >= array_length(pages)){
			instance_destroy()
		} else{
			char_i = 0
			page_done = false
		}
	}
}
