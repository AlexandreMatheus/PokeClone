extends Node

var has_saw_first_dialogue = false

func _ready():
	pass # Replace with function body.


func get_player():
	return get_node("/root/SceneManager/CurrentScene").get_children().back().find_node("Player")

func get_pokeball_count():
	var player = get_node("/root/SceneManager/CurrentScene").get_children().back().find_node("Player")
	return player.find_node('Count-Pokebola').get_children().back()

func get_memorial():
	return get_node("/root/SceneManager/Memorial")
	
func get_player_collision():
	var player = get_node("/root/SceneManager/CurrentScene").get_children().back().find_node("Player")
	return player.find_node('ObjectsColider')

func get_scene_manager():
	return get_node("/root/SceneManager")

func get_dialogue():
	return get_node("/root/SceneManager/Dialogue")

func get_game_manager():
	return get_node("/root/SceneManager/GameManager")
