extends Control

@export var TowerScenes: Dictionary # Dictionary of tower names and their PackedScenes
var selected_tower: PackedScene = null # The currently selected tower

func _ready():
	# Optional: Initialize with default tower type
	selected_tower = TowerScenes.get("TowerTypeA", null)
	for child in get_children():
		if child is Button:
			child.connect("tower_selected", _on_button_pressed)

func _on_button_pressed(tower_name: String):
	# Set the selected tower based on the button pressed
	if TowerScenes.has(tower_name):
		selected_tower = TowerScenes[tower_name]
		print("Selected Tower:", tower_name)
	else:
		print("Tower type not found:", tower_name)

# Example: Call this when placing a tower in the scene
func get_selected_tower() -> PackedScene:
	return selected_tower
