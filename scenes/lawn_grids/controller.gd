extends Node2D
"res://scenes/GUI/interface.tscn"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const peashooter = preload("res://scenes/peashooter/psh.tscn")
const sunflower = preload("res://scenes/sunflower/sunflower.tscn")


@onready var plantButton = $Control/AspectRatioContainer/HBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("TextureRect").visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("lane5"):
		$Camera2D.zoom -= Vector2(0.05, 0.05)
#	print(get_tree().get_nodes_in_group("lane1"))
	pass

func _on_Button_toggled(button_pressed):
	
	pass # Replace with function body.

func _hl_instance_id():
	pass
	
	
func _input(event):
	if $lawn_grid.currHL != null:
		if Input.is_mouse_button_pressed(1) and instance_from_id($lawn_grid.currHL).mouseArea == true and StatList.holding_plant == true and instance_from_id($lawn_grid.currHL).available == true and instance_from_id(StatList.seedpacket_id).button_pressed == true:
				#var plant_path = StatList.plants[instance_from_id(StatList.seedpacket_id).seedpacket]["path"]
				var plant = load(StatList.plants[instance_from_id(StatList.seedpacket_id).seedpacket]["path"])
				#var plant = load(strp)
				var ap = plant.instantiate()
				var pposition =  instance_from_id($lawn_grid.currHL).get_node("plant_position").global_position
				$Node2D.add_child(ap)
				ap.lane = instance_from_id($lawn_grid.currHL).lane
				print(ap.lane)
				ap.position = pposition
				ap.global_scale = Vector2(0.7, 0.7)
				match ap.lane:
					1: 
						ap.add_to_group("lane1") 
						ap.gr = "lane1"
						ap.lane = 1
					2: 
						ap.add_to_group("lane2")
						ap.gr = "lane2"
						ap.lane = 2
					3: 
						ap.add_to_group("lane3")
						ap.gr = "lane3"
						ap.lane = 3
					4: 
						ap.add_to_group("lane4")
						ap.gr = "lane4"
						ap.lane = 4
					5: 
						ap.add_to_group("lane5")
						ap.gr = "lane5"
						ap.lane = 5
				StatList.holding_plant = false
				instance_from_id($lawn_grid.currHL).available = false
				instance_from_id(StatList.seedpacket_id).seedPacket_reset()
			
