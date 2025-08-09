extends Node2D
var sun = false
var lane
var gr
var health: int = 100
var psun = preload("res://scenes/sun/sun.tscn")
var sunEmitted = false
func _ready():
	$AnimationPlayer.play("popup")
	$sunTimer.start()
	pass
	
func _process(delta):
		if health <= 0: queue_free()
		if $AnimatedSprite2D.animation == "sun" and $AnimatedSprite2D.frame == 52 and !sunEmitted:
			sunEmitted = true
			var pnsun = psun.instantiate()
			get_tree().get_root().add_child(pnsun)
			pnsun.yfloor = position.y
			pnsun.position = $sungen.global_position
			
			
		if Input.is_action_just_pressed("ui_up"):
			sun = true
		if Input.is_action_just_pressed("ui_down"):
			sun = false


func _on_AnimatedSprite_animation_finished():
	sun = false
	sunEmitted = false
	$sunTimer.start()
	print("herererere")
	$AnimatedSprite2D.play("std")

	if sun == true:
		$AnimatedSprite2D.set_animation("sun")
	else:
		$AnimatedSprite2D.set_animation("std")
	pass # Replace with function body.


func _on_sun_timer_timeout() -> void:
	sun = true
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_looped() -> void:
	if sun == true:
		$AnimatedSprite2D.play("sun")
	pass # Replace with function body.
