extends Node2D
var yfloor = 0
var yspeed = -3
var xspeed = 8
var fading = false
var picked = false
func _ready() -> void:
	$fadeTimer.start(10)
	$AnimationPlayer.play("popup_sun")
func _process(delta: float) -> void:
	if !picked:
		rotation += deg_to_rad(0.5)
		yspeed += 0.5
		if xspeed > 0:
			position.x += xspeed
			xspeed -= 0.4
		
		if position.y < yfloor:
			position.y += yspeed
			
	if fading:
		modulate.a -= 0.1
	if modulate.a <= 0:
		queue_free()


func _on_fade_timer_timeout() -> void:
	fading = true


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if picked:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and not event.is_echo():
		get_viewport().set_input_as_handled()
		move_sun_to_counter(self, StatList.counter_position)
		picked = true
		StatList.addSun(50)
		#queue_free()
		
func move_sun_to_counter(sun: Node2D, counter: Vector2):
	var tween := create_tween()
	var target_position := counter
	
	tween.tween_property(sun, "global_position", target_position, 0.8) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	#tween.parallel().tween_property(sun, "modulate:a", 0.0, 0.7) #\
	tween.tween_property(sun, "scale", Vector2.ZERO, 0.5)
		#.set_trans(Tween.TRANS_SINE) \
		#.set_ease(Tween.EASE_OUT)
	tween.tween_callback(sun.queue_free)
