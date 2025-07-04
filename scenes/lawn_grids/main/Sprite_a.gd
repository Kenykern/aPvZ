extends Sprite2D


func _ready():
	modulate.a = 0
	


func _process(delta):
	#if StatList.holding_plant == false:
	if get_parent().button_pressed == true or $"../TextureProgressBar".value != 0:
		modulate.a = 0.4
	else:
		modulate.a = 0
