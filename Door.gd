extends Area2D

export(String, FILE) var next_scene_path = ""
export(bool) var is_invisible = false
export(bool) var is_open = true
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

export(Vector2) var spanw_location = Vector2(0,0)
export(Vector2) var spanw_direction = Vector2(0,0)

var doorClosedDialogue = [
	{"name": "Porta", "text": "Está trancada."},
]

var player_entered = false

func _ready():
	if is_invisible:
		$Sprite.texture = null
	sprite.visible = false
	var player = Utils.get_player()
	player.connect("player_entering_door_signal", self, "enter_door")
	player.connect("player_entered_door_signal", self, "close_door")

func enter_door():
	if player_entered:
		animation_player.play("OpenDoor") 


func close_door():
	if player_entered:
		animation_player.play("CloseDoor")

func door_closed():
	if player_entered:
		Utils.get_scene_manager().transition_to_scene(next_scene_path, spanw_location, spanw_direction)

func _on_Door_body_entered(body):
	player_entered = true

func _on_Door_body_exited(body):
	player_entered = false

func closed_door_message():
	Utils.get_dialogue().start(doorClosedDialogue)
