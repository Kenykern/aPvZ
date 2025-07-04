extends Node2D
const spawn = preload("res://scenes/lawn_grids/spawn_controller.gd")
const zombie = preload("res://scenes/enemies/zombie/zombie.tscn")
var set = 0
@onready var p = get_parent()
func _ready():
	$stTimer.start(10)
	pass


func _on_stTimer_timeout():
	set += 1
	match set:
		1:
			p.spawn3(zombie)
			$stTimer.start(10)
		2:
			p.spawn1(zombie)
			p.spawn5(zombie)
			$stTimer.start(20)
		3:
			p.spawn3(zombie)
			p.spawn4(zombie)
			p.spawn1(zombie)
			$stTimer.start(15)
	pass # Replace with function body.
