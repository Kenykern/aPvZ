extends Node2D
var health = 100
var curr_health = 100
const head = preload("res://scenes/enemies/zombie/head_phs.tscn")
const arm = preload("res://scenes/enemies/zombie/arm_phs.tscn")
var state = "healthy"
var lane = 1
var eating = false
var fading = false
var planteat


func _ready():
#	$head_phs.modulate.a = 0
#	$head_phs2.modulate.a = 0
	
	
#	match lane:
#		1: $hitArea.collision_layer = 11
#		2: $hitArea.collision_layer = 12
#		3: $hitArea.collision_layer = 13
#		4: $hitArea.collision_layer = 14
#		5: $hitArea.collision_layer = 15
	pass
	
func _process(delta):
	if curr_health <= (health / 2) and state == "healthy":
		var currFrame = $an_zombie.get_frame()
		$an_zombie.set_animation("walk_noarm")
		$an_zombie.set_frame(currFrame)
		var darm = arm.instantiate()
		add_child(darm)
		darm.position = $arm_spawn.position
		darm.pgp = global_position
		#$head_phs2.pop_off()
		state = "hurt"
		
	if curr_health <= 0 and state == "hurt":
		var currFrame = $an_zombie.get_frame()
		$an_zombie.set_animation("walk_nohead")
		$an_zombie.set_frame(currFrame)
#		$head_phs.pop_off()
		var dhead = head.instantiate()
		add_child(dhead)
		dhead.position = $head_spawn.position
		dhead.pgp = global_position
		$hitArea.queue_free()
		state = "dead"
		
		if $an_zombie.animation == "death":
			if $an_zombie.get_frame() == 24:
				$an_zombie.stop()
		
#	if $an_zombie.is_playing("walk_nohead") and state == "dead":
#		$an_zombie.animation_finished
		
		
	if Input.is_action_just_pressed("ui_right"):
		curr_health -= 100
	#print(curr_health)
	
	if $an_zombie.get_frame() >= 38 and $an_zombie.get_frame() <= 55:
		global_position.x -= 1
	elif $an_zombie.get_frame() >= 55 and $an_zombie.get_frame() <= 67:
		global_position.x -= 0.5
	elif $an_zombie.get_frame() >= 78 and $an_zombie.get_frame() <= 82:
		global_position.x -= 1.2
	elif $an_zombie.get_frame() >= 101 and $an_zombie.get_frame() <= 123:
		global_position.x -= 1.1
	elif $an_zombie.get_frame() >= 123 and $an_zombie.get_frame() <= 131:
		global_position.x -= 1
	elif $an_zombie.get_frame() >= 137 and $an_zombie.get_frame() <= 183:
		global_position.x -= 0.5
		
	if fading == true:
		modulate.a -= 0.05
		
	if modulate.a < 0:
		queue_free()


func arm_down():
	pass
	
func _hit(damage):
	$damage_flash.play("damage_flash")
	curr_health -= damage



func _on_an_zombie_animation_finished():
	if state == "dead":
		$an_zombie.set_animation("death")
		$an_zombie.play()
		$fadeTimer.start()
	pass # Replace with function body.


func _on_fadeTimer_timeout():
	fading = true
	pass # Replace with function body.


func _on_hitArea_area_entered(area):
	pass # Replace with function body.


func _on_EatArea_area_entered(area):
	if area.is_in_group("plantcol") and area.get_parent().lane == lane and state != "dead":
		$an_zombie.stop()
		$an_zombie.set_frame(1)
		$EatTimer.start(1)
		eating = true
		planteat = area
	pass # Replace with function body.

func _on_EatArea_area_exited(area):
	_loc_await(randi() % 2)

	pass # Replace with function body.


func _on_EatTimer_timeout():
	var pe = weakref(planteat)
	if pe.get_ref() and state != "dead":
		pe.get_ref().get_parent().health -= 20
		pe.get_ref().get_parent().damage()
	else:
		$an_zombie.play()
	if eating == true:
		$EatTimer.start(1)
	pass # Replace with function body.
	
func _loc_await(time):
	await get_tree().create_timer(time).timeout
	$an_zombie.play()
	eating = false
		
