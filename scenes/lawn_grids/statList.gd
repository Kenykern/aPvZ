#GAMEPLAY GRID FORMED BY BUTTON COPIES FROM "pButton.tscn" AND TO BE INSTANTIATED ON THE MAIN GAMEPLAY SCENE
extends Control

var holding_plant = false
var seedpacket_id
var seedpacket = ""
var tooltipModulate
var sunCount: int = 50
signal sunChanged
var counter_position: Vector2


func _ready() -> void:
	#seedpacket = plants[seedpacket]
	pass
	
func addSun(amount: int = 50):
	sunCount += amount
	emit_signal("sunChanged")
	print("sun added")
func loseSun(amount):
	sunCount -= amount
	emit_signal("sunChanged")
	
var plants = {
	"peashooter": {"name":"Peashooter", "suncost":"100", "path":"res://scenes/peashooter/psh.tscn", "sphex":0x24ba6aff},
	
	"sunflower": {"name":"Sunflower", "suncost":"50", "path":"res://scenes/sunflower/sunflower.tscn", "spriteframes":"res://resources/spriteFrames/sunflower_std_anim.tres", "sphex":0xe5a76eff}}

const paths = {
	"peashooter":"res://scenes/peashooter/psh.tscn",
	"sunflower":"res://scenes/sunflower/sunflower.tscn"
}

func intensity_flash(node: Object, intensity: float = 1.3, duration: float = 0.08):
		var tween = create_tween()
		tween.tween_property(node, "modulate:r", intensity, duration)
		tween.parallel().tween_property(node, "modulate:g", intensity, duration)
		tween.parallel().tween_property(node, "modulate:b", intensity, duration)
		tween.tween_property(node, "modulate:r", 1, duration)
		tween.parallel().tween_property(node, "modulate:g", 1, duration)
		tween.parallel().tween_property(node, "modulate:b", 1, duration)
