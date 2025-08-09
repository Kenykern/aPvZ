extends TextureProgressBar

var charge_time = 5
var flashed = false

func _ready():
	modulate.a = 0.7
	value = charge_time
	max_value = charge_time
func _process(delta):
	value -= delta
	if value != 0:
		flashed = false
		get_parent().disabled = true
		get_parent().mouse_default_cursor_shape = Control.CURSOR_ARROW
		$"../AnimatedSprite2D".stop()
	else:
		if !flashed:
			StatList.intensity_flash(get_parent())
			flashed = true
		get_parent().disabled = false
		get_parent().mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		if !$"../AnimatedSprite2D".is_playing():
			$"../AnimatedSprite2D".play()
