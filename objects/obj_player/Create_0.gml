//define variables
xspd = 0
yspd = 0

//light world speeds (deltarune)
move_spd = 3
walk_spd = 3
run_spd = 6
run_acc = 0.1

//walk anim: 0 idle, 1 left, 2 idle, 3 right
//taps alternate: step, slide, step, slide...
//step_i: 0 left, 1 idle slide, 2 right, 3 idle slide
step_i = -1
walk_cycle = 0
walk_anim_spd = 4
was_moving = false
image_speed = 0
image_index = 0

//party follow history, start trail behind susie
follow_points = 40
follow_space = 3
var trail_dx = 0
var trail_dy = -1
for(var i = 0; i < follow_points; i++){
	follow_x[i] = x + trail_dx * i * follow_space
	follow_y[i] = y + trail_dy * i * follow_space
	follow_face[i] = 0
	follow_img[i] = 0
}

//spawn kris if he isnt already here
if(!instance_exists(obj_kris)){
	instance_create_depth(follow_x[12], follow_y[12], depth + 1, obj_kris)
}
