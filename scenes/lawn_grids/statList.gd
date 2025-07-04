#GAMEPLAY GRID FORMED BY BUTTON COPIES FROM "pButton.tscn" AND TO BE INSTANTIATED ON THE MAIN GAMEPLAY SCENE
extends Control

var holding_plant = false
var seedpacket_id

var plants = {
	"peashooter": {"name":"Peashooter", "suncost":"100", "path":"res://scenes/peashooter/psh.tscn"},
	
	"sunflower": {"name":"Sunflower", "suncost":"50", "path":"res://scenes/sunflower/sunflower.tscn"}
}

const paths = {
	"peashooter":"res://scenes/peashooter/psh.tscn",
	"sunflower":"res://scenes/sunflower/sunflower.tscn"
}
