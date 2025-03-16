extends Node2D

@export var range: float = 200.0
@export var fire_rate: float = 1.0

var can_shoot = true

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) <= range:
			if can_shoot:
				shoot(enemy)
				can_shoot = false
				await get_tree().create_timer(fire_rate)
				can_shoot = true

func shoot(enemy) -> void:
	print("Shooting at: ", enemy.name)
	# Add projectile or damage logic here
