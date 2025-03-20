extends Node2D

@export var spawnable_objects: Array[Resource]
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
	var enemy = pick_random_spawnable()
	#add_child(enemy)
	# Get the Path2D from the provided path
	var path2d = get_node(path) as Path2D
	if path2d:
		path2d.add_child(enemy)

func pick_random_spawnable():
	var total_probability = 0.0
	for obj in spawnable_objects:
		total_probability += obj.spawn_probability

	var random_value = randf() * total_probability
	var cumulative_probability = 0.0

	for obj in spawnable_objects:
		cumulative_probability += obj.spawn_probability
		if random_value <= cumulative_probability:
			return obj.scene.instantiate() # Return the instantiated scene
	return null
