extends PathFollow2D

@export var speed: float = 100.0

func _process(delta: float) -> void:	
	progress += speed * delta
	if progress_ratio == 1:
		queue_free()  # Remove the enemy once it reaches the end
