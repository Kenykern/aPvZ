extends Node2D

#@export var sprite_frames: SpriteFrames
@export var outline_color: Color  = Color(0xe5a76eff)
@export var edge_threshold: float = 1
@export var outline_size: float   = 0.2
@export var bg_color: Color       = Color(0xe5a76eff)
@onready var colorrect = $ColorRect
func _ready(): call_deferred("_deferred") #it needs more time for the parent button to fully load


func _deferred():
	$ColorRect.size = get_parent().size
	$ColorRect.color = bg_color
	scale = Vector2(1,1)
	# 2. Material + shader


	
	$ColorRect/AnimatedSprite2D.position = get_parent().spritePosition
	$ColorRect/AnimatedSprite2D.scale = Vector2(0.4,0.4)
	
	var scn = get_parent().set_packet
	var scene = load(scn["path"]).instantiate()
	$ColorRect.color = scn["sphex"]
	outline_color = scn["sphex"]
	var sprite_frames = scene.get_node("AnimatedSprite2D").sprite_frames
	$ColorRect/AnimatedSprite2D.frames   = sprite_frames

	
	var mat = ShaderMaterial.new()
	mat.shader = preload("res://shaders/2sobel_outline.gdshader")
	mat.set_shader_parameter("outline_color",   outline_color)
	mat.set_shader_parameter("edge_threshold",  edge_threshold)
	mat.set_shader_parameter("outline_size",    outline_size)
	
	$ColorRect/AnimatedSprite2D.material = mat
	$ColorRect/AnimatedSprite2D.play()
