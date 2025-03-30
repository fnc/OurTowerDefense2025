extends CanvasLayer


func _process(delta):
	# Update the Label text with the global variable values
	$MoneyLabel.text = "$: " + str(GameManager.money)
	$HealthLabel.text = "Health: " + str(GameManager.lives)
	$WaveLabel.text = "Wave: " + str(GameManager.current_wave)
	
