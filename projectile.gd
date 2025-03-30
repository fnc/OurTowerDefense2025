extends Node2D

@export var speed: float = 300.0
@export var damage: float = 50.0
var target: Node2D

func _process(delta: float):
	if target and target.is_inside_tree():
		var direction = (target.global_position - global_position).normalized()
		position += direction * speed * delta

		if position.distance_to(target.global_position) < 10:
			target.take_damage(damage) # Custom method for enemy damage
			queue_free() # Destroy the projectile
	else:
		queue_free() # Destroy if target is invalid
