extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Utils.has_saw_first_dialogue:
		Utils.has_saw_first_dialogue = true
		$TownTransitions/AnimationPlayer.play("InitialFadeToNormal")
