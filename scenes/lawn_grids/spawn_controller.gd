extends Node2D
const zombie = preload("res://scenes/enemies/zombie/zombie.tscn")

var wave = 0
var stage = 0
var set = 0
var start_time = 8

#spawn x times between waves
var waveLenght = 8
#max number of zombies between spawn sets
var foreWaveSpawnRange = 3

func _ready():
	randomize()
#	$stTimer.wait_time = start_time
#	$stTimer.start()
	pass


 

func startup():
	spawn_random(zombie)
	pass
	
func spawn_random(z):
	var rng_spawn = randf_range(1, foreWaveSpawnRange + 1)
	rng_spawn = int(rng_spawn)
	
	for n in rng_spawn:
		var rand = randf_range(1, 6)
		rand = int(rand)
		print(rand)
		match rand:
			1: spawn1(z)
			2: spawn2(z)
			3: spawn3(z)
			4: spawn4(z)
			5: spawn5(z)

#func set(zombie_type, lane, ):
		
func spawn1(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	newZ.get_node("an_zombie").set_frame(randi() % 212); newZ.get_node("an_zombie").play()
	newZ.add_to_group("lane1")
	newZ.lane = 1
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn1".global_position + rand
	
func spawn2(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	newZ.get_node("an_zombie").set_frame(randi() % 212); newZ.get_node("an_zombie").play()
	newZ.lane = 2
	newZ.add_to_group("lane2")
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn2".global_position + rand
	
func spawn3(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	newZ.get_node("an_zombie").set_frame(randi() % 212); newZ.get_node("an_zombie").play()
	newZ.lane = 3
	newZ.add_to_group("lane3")
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn3".global_position + rand
	
func spawn4(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	newZ.get_node("an_zombie").set_frame(randi() % 212); newZ.get_node("an_zombie").play()
	newZ.lane = 4
	newZ.add_to_group("lane4")
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn4".global_position + rand

func spawn5(z):
	var rand = Vector2(randf_range(-20, 200), randf_range(-10, 10))
	var newZ = z.instantiate()
	newZ.get_node("an_zombie").set_frame(randi() % 212); newZ.get_node("an_zombie").play()
	newZ.lane = 5
	newZ.add_to_group("lane5")
	$"../Node2D".add_child(newZ)
	newZ.global_position = $"../spawn5".global_position + rand
	
func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		spawn_random(zombie) 
