extends Node2D
var sun = false
var lane
var gr
func _ready():
	$AnimationPlayer.play("popup")
	pass
	
func _process(delta):
		if Input.is_action_just_pressed("ui_up"):
			sun = true
		if Input.is_action_just_pressed("ui_down"):
			sun = false


func _on_AnimatedSprite_animation_finished():
	if sun == true:
		$AnimatedSprite2D.set_animation("sun")
	else:
		$AnimatedSprite2D.set_animation("std")
	pass # Replace with function body.
