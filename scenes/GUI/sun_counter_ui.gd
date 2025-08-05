extends Control

func _ready() -> void:
	StatList.counter_position = global_position
	StatList.connect("sunChanged", Callable(self, "_update_counter"))
	
func _update_counter():
	print(StatList.sunCount)
	$RichTextLabel.text = str(StatList.sunCount)
