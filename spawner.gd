extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_rate: float = 2.0

func _ready() -> void:
	spawn_enemy()
	await get_tree().create_timer(spawn_rate)
	_ready()  # Spawn loop

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
