extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = "idle"
var pea = preload("res://scenes/peashooter/pea/pea.tscn")
var shot = false
var health = 100
var lane
var gr = "foes"
@onready var foeCol = get_node("foeCollision")



# Called when the node enters the scene tree for the first time.
func _ready():
	$TargetCheck.start(2)
	$AnimationPlayer.play("popup")
	$foeCollision.collision_layer = 10
	$foeCollision.collision_mask = 10
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currAnim = $AnimatedSprite2D.get_animation()
	
	if Input.is_action_just_pressed("ui_accept") and state == "idle":
		state = "shooting"
	elif Input.is_action_just_pressed("ui_accept") and state == "shooting":
		state = "idle"
		
	if currAnim == "shoot" and $AnimatedSprite2D.get_frame() == 38 and shot == false:
		shot = true
		var cPea = pea.instantiate()
		cPea.lane = lane
		cPea.global_position = $Node2D.global_position + Vector2(0,160)
		get_parent().add_child(cPea)
		
		

		$CPUParticles2D.modulate.a = 1
		
	if $CPUParticles2D.modulate.a != 0:
		$CPUParticles2D.modulate.a -= 0.09
	if health <= 0: queue_free()
	if modulate.a < 1: modulate.a += 0.05
#	print(foeCol.get_overlapping_bodies())
#	if foeCol.overlaps_area() != null:
#		state = "idle"
#	pass


func _on_AnimatedSprite_animation_finished():
	shot = false
	if state == "shooting":
		$AnimatedSprite2D.play("shoot")
	elif state == "idle":
		$AnimatedSprite2D.play("std")
	pass # Replace with function body.


func target_check():
	pass




func _on_TargetCheck_timeout():
	var foes = get_tree().get_nodes_in_group(gr)
	for i in foes.size():
		if foes[i].is_in_group("foe") and foes[i].state != "dead" and foes[i].global_position >= global_position:
			state = "shooting"
			break
		else:
			state = "idle"
	pass # Replace with function body.

func damage():
	modulate.a = 0.5
