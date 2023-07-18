
extends Area2D

func _ready():
	pass # Replace with function body.

func has_interaction_collision() -> bool:
	if len(get_overlapping_bodies()) > 0:
		return true
	return false

func get_name() -> String:
	if len(get_overlapping_bodies()) > 0:
		var objeto = get_overlapping_bodies()[0]
		return objeto.get_name()
	else:
		return ''

func delete_item() -> void:
	if len(get_overlapping_bodies()) > 0:
		var objeto: StaticBody2D = get_overlapping_bodies()[0] as StaticBody2D
		objeto.queue_free()

func is_item() -> bool:
	if len(get_overlapping_bodies()) > 0:
		var objeto = get_overlapping_bodies()[0]
		return objeto.is_item()
	else:
		return false
