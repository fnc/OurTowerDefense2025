extends Node

@export var take_hit: AudioStreamPlayer
@export var shot: AudioStreamPlayer
@export var bg_loop: AudioStreamPlayer
@export var UIClick: AudioStreamPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		UIClick.play()
