extends StaticBody2D

export(String) var nome = ''
export(bool) var is_item = false

func _ready():
	pass # Replace with function body.

func get_name() -> String:
	return nome

func is_item() -> bool:
	return is_item
