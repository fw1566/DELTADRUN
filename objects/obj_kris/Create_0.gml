//define variables

//how many recorded steps back kris walks behind susie. since each recorded step is one
//point along her actual path, kris naturally falls further behind in real distance while
//she's running (each step covers more ground) and catches back up while walking slowly --
//exactly like partners in the actual game
target = 8

spr_d = spr_kriswd
spr_r = spr_kriswr
spr_u = spr_kriswu
spr_l = spr_kriswl

//copies susies walk frames from the path
sprite_index = spr_d
image_speed = 0
image_index = 0
