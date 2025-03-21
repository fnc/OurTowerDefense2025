extends Node2D

# Preload the scene or tower object you want to place
@export var TowerScene: PackedScene

# Reference to the grid or game area
@export var GameArea: Node2D
@export var Path: Path2D
@export var PathClearence: float

func _ready():
	set_process_input(false)

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
	# Check if the position overlaps another tower's radius
	for child in GameArea.get_children():
		#if child is KinematicBody2D or StaticBody2D:  # Assuming towers are bodies
			var tower_radius = 64  # Adjust this based on your tower's effective radius
			if child.position.distance_to(position) < tower_radius:
				print("Cannot place tower: Overlaps another tower's radius.")
				return false

	# Check if the position is on or near the path
	if is_near_path(position):
		print("Cannot place tower: Too close to or on the path.")
		return false

	return true

func is_near_path(position: Vector2) -> bool:
	var curve = Path.curve # Get the Curve2D from the Path2D
	if not curve:
		print("Curve2D not found.")
		return false

	var clearance_radius = PathClearence  # Minimum distance from the path
	var closest_distance = curve.get_closest_point(position).distance_to(position)

	return closest_distance < clearance_radius
