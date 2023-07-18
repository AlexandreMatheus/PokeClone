extends AudioStreamPlayer2D

func _ready():
	pass 

func _on_AudioStreamPlayer2D_finished():
	$'.'.play
