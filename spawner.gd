extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_rate: float = 2.0
@export var path: NodePath  # Path2D node reference

func _ready() -> void:
	spawn_enemy_loop()

func spawn_enemy_loop() -> void:
	# Continuously spawn enemies at intervals
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_rate).timeout

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	#add_child(enemy)
	# Get the Path2D from the provided path
	var path2d = get_node(path) as Path2D
	if path2d:
		path2d.add_child(enemy)
