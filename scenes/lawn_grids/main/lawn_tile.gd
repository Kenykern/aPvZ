extends Area2D
var mouseArea = false
var available = true
var shOwner
signal instID(instid1)
var currId
@export var lane: int
func _ready():
	$Polygon2D.set_color(Color(1,1,1,0))
func _process(delta):
	pass


func _on_Area2D_mouse_entered():
	$Polygon2D.set_color(Color(1,1,1,0.4))
	currId = get_instance_id()
	mouseArea = true
	#shOwner = shape_owner_get_owner(currId)
	#emit_signal("instid1", shOwner) 
	get_owner().currHL = currId
	print(get_owner().currHL)



func _on_Area2D_mouse_exited():
	$Polygon2D.set_color(Color(1,1,1,0))
	mouseArea = false


