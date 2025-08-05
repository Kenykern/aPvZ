extends NinePatchRect

var mousePos = Vector2()
var showLabel = false

@onready var set_packet
#@onready var set_packet = StatList.plants[get_parent().seedpacket]

func _ready():
	
	if StatList.plants.has(StatList.seedpacket):
		print("grab")
		set_packet = StatList.plants[StatList.seedpacket]
		print(StatList.plants[StatList.seedpacket])
		$PlantName.set_text(set_packet["name"])
		$SunCost.set_text("Cost: " + set_packet["suncost"])
	modulate.a = 0
	pass

func _process(delta):
	if StatList.plants.has(StatList.seedpacket):
		#print("grab")
		set_packet = StatList.plants[StatList.seedpacket]
		#print(StatList.plants[StatList.seedpacket])
		$PlantName.set_text(set_packet["name"])
		$SunCost.set_text("Cost: " + set_packet["suncost"])
	#raise()
	if showLabel ==  true:
		if modulate.a < 1:
			modulate.a += 0.1
	else:
		modulate.a = 0
		
	position = Vector2(get_global_mouse_position().x + 15, get_global_mouse_position().y)
	#print(position)
	pass

#func _input(event):
#	if event is InputEventMouseMotion:
#		mousePos = event.position

#not working... signals don't work directly for nodes that are not part of their scene treet
func _on_SeedPacket_mouse_entered():
	showLabel = true
	var mousePos2 = get_global_mouse_position() 
	if get_global_rect().has_point(mousePos2):
		print("mouse entered: " + name)
		StatList.seedpacket = set_packet
	pass # Replace with function body.


func _on_SeedPacket_mouse_exited():
	print("should fade")
	showLabel = false
	pass # Replace with function body.
