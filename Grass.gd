extends Node2D

onready var anim_player = $AnimationPlayer

const grass_overlay_texture = preload("res://Assets/Grass/stepped_tall_grass.png")
var grass_overlay: TextureRect = null
const GrassStepEffect = preload("res://GrassStepEffect.tscn")
var player_inside: bool = false

func _ready():
	var player = Utils.get_player()
	player.connect("player_moving_signal", self, "player_exiting_grass")
	player.connect("player_stopped_signal", self, "player_in_grass")


func player_exiting_grass():
	player_inside = false
	if is_instance_valid(grass_overlay):
		grass_overlay.queue_free()
	
func player_in_grass():
	if player_inside == true:
		var grass_step_effect = GrassStepEffect.instance()
		grass_step_effect.position = position
		get_tree().current_scene.add_child(grass_step_effect)
		grass_overlay = TextureRect.new()
		grass_overlay.texture = grass_overlay_texture
		grass_overlay.rect_position = position
		get_tree().current_scene.add_child(grass_overlay)

func _on_Area2D_body_entered(body):
	player_inside = true
	anim_player.play("Stepped")
