extends Node2D

@export var spawnable_objects: Array[Resource]
@export var spawn_rate: float = 2.0
@export var path: NodePath  # Path2D node reference
@export var startButton: Button
@export var base_enemy_count = 3

#func _ready() -> void:
	#spawn_enemy_loop()
	#$StartWaveButton.connect("pressed", _on_StartWaveButton_pressed)

func _on_StartWaveButton_pressed():
	GameManager.current_wave += 1  # Increment the wave count
	
	# Calculate logarithmic scaling for enemy count and spawn rate
	var scaled_enemy_count = int(base_enemy_count + (0.8 * GameManager.current_wave))
	var scaled_spawn_rate = spawn_rate / (log(1 + GameManager.current_wave)/log(10))
	
	# Ensure scaled_spawn_rate doesn't become too small
	scaled_spawn_rate = max(scaled_spawn_rate, 0.1)
		# Trigger the wave
	spawn_enemy_waves({"enemy_count": scaled_enemy_count, "spawn_rate": scaled_spawn_rate})


func spawn_enemy_loop() -> void:
	# Continuously spawn enemies at intervals
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_rate).timeout
		
func spawn_enemy_waves(wave) -> void:
	startButton.disabled = true  # Disable button while spawning enemies
	for i in range(wave["enemy_count"]):
		spawn_enemy()
		await get_tree().create_timer(wave["spawn_rate"]).timeout
	startButton.disabled = false  # Re-enable button after wave
	print("Wave complete!")

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
