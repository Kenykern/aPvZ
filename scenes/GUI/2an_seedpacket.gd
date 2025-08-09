extends Node2D

@export var bg_color: Color = Color(0.2, 0.6, 1.0)   # color de fondo clave
@export var sprite_frames: SpriteFrames            # asigna aquí tu SpriteFrames con la animación

func _ready():
	# 1. Configurar fondo
	$ColorRect.color = bg_color

	# 2. Crear y asignar el shader de silueta
	var shader_code = """
shader_type canvas_item;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = vec4(1.0, 1.0, 1.0, tex.a);
}
"""
	var shim = Shader.new()
	shim.code = shader_code

	var mat = ShaderMaterial.new()
	mat.shader = shim

	# 3. Configurar AnimatedSprite2D
	$AnimatedSprite2D.frames = sprite_frames
	$AnimatedSprite2D.material = mat
	$AnimatedSprite2D.play()   # inicia la animación predeterminada
