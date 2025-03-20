extends Node

@export var initial_lives: int = 100;
var score: int = 0 # Keep track of the total score
var lives: int = initial_lives # Lives remaining in the game

func _ready():
	# Initialize score or lives, if necessary
	print("GameManager ready")

func _on_enemy_defeated(points_value):
	score += points_value
	print("Enemy defeated! Points added:", points_value, "| Total score:", score)

func _on_enemy_reached_end(points_value):
	lives -= 1
	print("Enemy reached end! Points lost:", points_value, "| Lives remaining:", lives)

	# Check for game over
	if lives <= 0:
		game_over()

func game_over():
	print("Game Over!")
	# Add game over logic (e.g., show game over screen or restart game)
