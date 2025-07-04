extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 15
var damage = 10
var lane
var relSpawn
var areas = [0]
var used = false
# Called when the node enters the scene tree for the first time.
func _ready():
	relSpawn = global_position
	pass # Replace with function body.

func _process(delta):
	position.x += speed
	match lane:
		1: add_to_group("lane1")
		2: add_to_group("lane2")
		3: add_to_group("lane3")
		4: add_to_group("lane4")
		5: add_to_group("lane5")
	if position.x > get_viewport().size.x + 300:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	areas = $colArea.get_overlapping_areas()


func _on_colArea_area_entered(area):
	
#	if area.is_in_group("foe"):
#		var foearr = []
#		match lane:
#			1: foearr = get_tree().get_nodes_in_group("lane1")
#			2: foearr = get_tree().get_nodes_in_group("lane2")
#			3: foearr = get_tree().get_nodes_in_group("lane3")
#			4: foearr = get_tree().get_nodes_in_group("lane4")
#			5: foearr = get_tree().get_nodes_in_group("lane5")
	
	if area.is_in_group("foe") and used == false:
		used = true
		speed = 0
		area.get_parent()._hit(damage)
		queue_free()
		
		#code to prevent pea to hit multiple overlapping targets, only the one closer
#		var tohit
#		#relative to spawn rather than scene global origin, that's what substraction is used for
#		var current = 0
#		var closest = 50000
#		for i in foearr.size():
#			if foearr[i].is_in_group("foe") and foearr[i].state != "dead":
#				current = foearr[i].global_position.x - global_position.x
#				if current < closest and current >= 0:
#					closest = current
#					tohit = foearr[i]
#		if tohit != null:
#			tohit._hit(damage)
#		queue_free()
#		print(lane)
#		print(area.lane)
#		#if lane == area.lane:
		
#		speed = 0
#		$colArea.queue_free()
#		$destroyTimer.start()
		
		#var particlesGpos = $CPUParticles2D.global_position
		#get_parent().get_parent().add_child($CPUParticles2D)
		#get_node("/../..").add_child($CPUParticles2D)
		#$CPUParticles2D.global_position = particlesGpos
		$CPUParticles2D.emitting = true
		pass # Replace with function body.


#func _on_destroyTimer_timeout():
#	queue_free()
#	pass # Replace with function body.
