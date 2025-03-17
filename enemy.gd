extends PathFollow2D

@export var speed: float = 100.0
@export var health: int = 100  # Enemy health

func _ready():
	# Add the node to a group named "example_group"
	add_to_group("enemies")

func _process(delta: float) -> void:	
	progress += speed * delta
	if progress_ratio == 1:
		queue_free()  # Remove the enemy once it reaches the end

func take_damage(amount: int) -> void:
	health -= amount  # Reduce health
	if health <= 0:
		queue_free()  # Remove the enemy when health reaches zero
