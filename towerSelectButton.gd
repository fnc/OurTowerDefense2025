extends TextureButton

@export var tower_name: String # Tower type associated with the button
signal tower_selected(tower_name: String)

func _on_pressed():
	emit_signal("tower_selected", tower_name) # Emit the signal with the tower name
