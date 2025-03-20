extends PathFollow2D

@export var points_value: int = 10 # Value of this enemy
@export var speed: float = 100.0
@export var health: int = 100  # Enemy health

func _ready():
	# Add the node to a group named "example_group"
	add_to_group("enemies")

func _process(delta: float) -> void:	
	progress += speed * delta
	if progress_ratio == 1:
		emit_signal("enemy_reached_end", points_value)
		queue_free()  # Remove the enemy once it reaches the end

func take_damage(amount: int) -> void:
	health -= amount  # Reduce health
	if health <= 0:
		emit_signal("enemy_defeated", points_value)
		queue_free()  # Remove the enemy when health reaches zero
