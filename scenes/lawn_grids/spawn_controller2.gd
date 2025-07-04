extends Node2D
const zombie = preload("res://scenes/enemies/zombie/zombie.tscn")


var start_time = 8

func _ready():
	$stTimer.wait_time = start_time
	$stTimer.start()
	pass


func _on_stTimer_timeout():
	startup()


func startup():
	spawn_random(zombie)
	pass
	
func spawn_random(z):
	var rand = randf_range(1, 5)
	rand = int(rand)
	print(rand)
	match rand:
		1: spawn1(z)
		2: spawn2(z)
		3: spawn3(z)
		4: spawn4(z)
		5: spawn5(z)
		
func spawn1(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn1".global_position + rand
	
func spawn2(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn2".global_position + rand
	
func spawn3(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn3".global_position + rand
	
func spawn4(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn4".global_position + rand

func spawn5(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn5".global_position + rand
