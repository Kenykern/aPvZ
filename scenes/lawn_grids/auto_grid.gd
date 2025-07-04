extends Node2D
#var size = Vector2(1,1)
var resx = ProjectSettings.get_setting("display/window/size/viewport_width")
var resy = ProjectSettings.get_setting("display/window/size/viewport_height")
var marginScale = 0.1
var lanes = 5
var pixelScale1
var pixelScale2

func _ready():
	pixelScale1 = Vector2(position.x, position.y)
	pixelScale2 = Vector2($v2.position.x, $v2.position.y)
	pass # Replace with function body.
	#self.scale = size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(resx)

	pass
func _draw():
	var rect = Rect2(pixelScale1, pixelScale2)
	draw_rect(rect, Color( 1, 1, 1, 1 ), true)
