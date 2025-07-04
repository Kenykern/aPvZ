extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prepsh = preload("res://scenes/peashooter/psh.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_mouse_button_pressed(1):
		var psh = prepsh.instantiate()
		add_child(psh)
		psh.position = get_global_mouse_position()
		psh.scale = Vector2(0.4,0.4)
	pass
