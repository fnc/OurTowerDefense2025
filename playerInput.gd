extends Node2D

# Preload the scene or tower object you want to place
@export var TowerScene: PackedScene

# Reference to the grid or game area
@export var GameArea: Node2D

func _ready():
	set_process_input(true)

# Detect input for placing towers
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			place_tower(event.position)

func place_tower(global_mouse_position: Vector2):
	# Convert global mouse position to local position within the game area
	var local_mouse_position = GameArea.to_local(global_mouse_position)
	
	# Snap the position to a grid (e.g., 32x32)
	var snapped_position = local_mouse_position.snapped(Vector2(32, 32))
	
	# Ensure the position is valid for placing towers
	if is_valid_position(snapped_position):
		var tower_instance = TowerScene.instantiate()
		tower_instance.position = snapped_position
		GameArea.add_child(tower_instance)
	else:
		print("Invalid position for tower placement.")

func is_valid_position(position: Vector2) -> bool:
	# Example: Check if there's already a tower at this position
	for child in GameArea.get_children():
		if child.position == position:
			return false
	return true
