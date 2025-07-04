extends Node2D
var hspeed = 4
var vspeed = -5
var rotspeed = 0.05
var onfloor = false
var pgp
var globalp
var upd = true
var pdiff
func _ready():
	randomize()
	hspeed = randf_range(1, 2)
	vspeed = randf_range(-3, -1)
	rotspeed = randf_range(0.03, 0.05)
	#set_as_top_level(true)
	pass

func _process(delta):
	global_position = global_position + Vector2(hspeed, vspeed)
	rotation += rotspeed
	if global_position.y >= get_parent().global_position.y:
		vspeed = 0
		if hspeed > 0:
			hspeed -= 0.2
		if rotspeed > 0:
			rotspeed -= 0.001
		if hspeed <= 0:
			rotspeed = 0
			hspeed = 0
		if hspeed <= 0 and onfloor == false:
			globalp = global_position
			
	else:
		vspeed += 0.5
		
	if upd == false:
		var result = pdiff - get_parent().global_position.x
		global_position.x += result
		upd = true
	
	if upd == true:
		pdiff = get_parent().global_position.x
		upd = false
		
		
	
