
extends RigidBody2D
var fading = false

func _ready():
	$head.scale = get_parent().scale
	$CollisionPolygon2D.scale = get_parent().scale
	match get_parent().lane:
		1: collision_mask = 2
		2: collision_mask = 3
		3: collision_mask = 4
		4: collision_mask = 5
		5: collision_mask = 6
	#sleeping = true
	pass

func _physics_process(delta):
	if fading == true and $head.modulate.a > 0:
		$head.modulate.a -= 0.05
	pass
	
func pop_off():
	var yrng = randf_range(-200, -600)
	var xrng = randf_range(30, 50)
	mode = RigidBody2D.MODE_RIGID
	$Timer.start()
	$fadetimer.start()
	apply_impulse(Vector2(xrng, yrng), Vector2(0,0))
	gravity_scale = 20
	modulate.a = 1

	pass
	
func _on_Timer_timeout():
	applied_torque = 0
	applied_force = Vector2(0, 0)
	weight = 0
	mass = 0
	angular_damp = 0
	
#	applied_force = Vector2(600, 0)
#	gravity_scale = 5
	pass # Replace with function body.

func _on_head_phs_body_entered(body):
	applied_torque = 0
	applied_force = Vector2(0, 0)
	gravity_scale = 0
	weight = 0
	mass = 0
	angular_damp = 0
	pass # Replace with function body.


func _on_fadetimer_timeout():
	fading = true
	pass # Replace with function body.
