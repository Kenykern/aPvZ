# INDIVIDUAL BUTTON FOR "seed_planter.tscn"
extends Button

#later to be used by "main.tscn"
@export var seedpacket: String
#where all the plant and properties are in a dictionary

@onready var set_packet = StatList.plants[seedpacket]

func _on_ready():
	pass
	
func _process(delta):
#	if Input.is_mouse_button_pressed(2) and pressed == true:
#		pressed = false
		
	if is_pressed():
		if StatList.seedpacket_id != get_instance_id():
			pass
#			pressed = false
	pass


func _on_SeedPacket_toggled(button_pressed):
	StatList.holding_plant = true
	StatList.seedpacket_id = get_instance_id()

	pass # Replace with function body.

func seedPacket_reset():
	$TextureProgressBar.value = $TextureProgressBar.charge_time
#	pressed = false
