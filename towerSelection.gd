extends Control

@export var TowerScenes: Dictionary # Dictionary of tower names and their PackedScenes

func _ready():
	# Optional: Initialize with default tower type
	GameManager.selected_tower = TowerScenes.get("TowerSapito", null)
	#for grid in get_children():
	#	for button in grid.get_children():
	#		if button is TextureButton:
	#			button.connect("tower_selected",_on_button_pressed)

func _on_button_pressed(tower_name: String):
	# Set the selected tower based on the button pressed
	if TowerScenes.has(tower_name):
		GameManager.selected_tower = TowerScenes[tower_name]
		print("Selected Tower:", tower_name)
	else:
		print("Tower type not found:", tower_name)

# Example: Call this when placing a tower in the scene
func get_selected_tower() -> PackedScene:
	return GameManager.selected_tower
