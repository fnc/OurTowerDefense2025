extends Node2D

@export var spawnable_objects: Array[Resource]
@export var spawn_rate: float = 2.0
@export var path: NodePath  # Path2D node reference
@export var startButton: Button
@export var base_enemy_count = 15

func _on_StartWaveButton_pressed():
	GameManager.current_wave += 1  # Incrementa la ola actual
	
	# Nueva fórmula para el número de enemigos (crece más rápido)
	var scaled_enemy_count = int(base_enemy_count * pow(1.3, GameManager.current_wave))
	
	# Ajustar la tasa de aparición de enemigos (para evitar valores demasiado pequeños)
	var scaled_spawn_rate = max(spawn_rate * pow(0.95, GameManager.current_wave), 0.3)

	# Iniciar la ola
	spawn_enemy_waves({"enemy_count": scaled_enemy_count, "spawn_rate": scaled_spawn_rate})

func spawn_enemy_waves(wave) -> void:
	startButton.disabled = true  # Deshabilitar botón mientras se generan enemigos
	for i in range(wave["enemy_count"]):
		spawn_enemy()
		await get_tree().create_timer(wave["spawn_rate"]).timeout
	startButton.disabled = false  # Rehabilitar botón tras la ola
	GameManager.money += 202 - (GameManager.current_wave * 2)
	print("Wave complete!")

func spawn_enemy() -> void:
	var enemy = pick_random_spawnable()
	var path2d = get_node(path) as Path2D
	if path2d and enemy:
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
			return obj.scene.instantiate() # Instanciar la escena
	return null
