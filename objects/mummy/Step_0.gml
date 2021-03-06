/// @desc

if P exit

if walk_left {
	
	image_xscale = 1
	
	hsp -= acc
	
	hsp = approach(hsp, -hsp_max, acc*1.1)
	
} else {
	
	image_xscale = -1
	
	hsp += acc
	hsp = approach(hsp, hsp_max, acc*1.1)
	
}

if place_meeting(x, y + 1, parent_collision) {
	
	if random(1) < 0.02 {
		vsp -= random_range(3, 4.5)
	}
	
	falling_timer = 0
	
} else {
	
	//If we are falling
	falling_timer += 1
	
}
if falling_timer > 60*16 { instance_destroy() }

vsp += grv
vsp = approach(vsp, vsp_max, grv*1.1)


//Turn towers the player once
if point_distance(x, y, player.x, player.y) < 70
and not collision_line(x, y, player.x, player.y, parent_collision, false, true)
and have_turned_to_player == false {
	
	have_turned_to_player = true
	
	if player.x > x { walk_left = false } 
	if player.x <= x { walk_left = true } 
	
}



#region Collision (Vertical and Horizontal)
		
	//Horizontal Collision
	if (place_meeting(x +hsp, y, parent_collision))
	{
		while (!place_meeting(x+sign(hsp),y,parent_collision))
		{
			x += sign(hsp)	
		}
		hsp = 0
		walk_left = not walk_left
	}
	x += hsp

	//Vertical Collision
	if (place_meeting(x,y+vsp,parent_collision))
	{
		while (!place_meeting(x,y+sign(vsp),parent_collision))
		{
			y += sign(vsp)	
		}
		vsp = 0
	}
	y += vsp
		
#endregion

if place_meeting(x, y, parent_collision) {
	instance_destroy()	
	//show_message("sbuisdgbuisgbui")
}

