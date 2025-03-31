extends Node2D

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 1.0
@export var projectile_damage: float = 1.0
@export var range: float = 200.0
@export var fire_rate: float = 1.0
@export var price: int = 10 # Price of this tower

var can_shoot = true

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) <= range:
			if can_shoot:
				shoot(enemy)
				start_fire_timer()
				break # Stop after shooting one enemy

func shoot(enemy) -> void:
	AudioManager.shot.play()
	# Add projectile or damage logic here
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.target = enemy
	projectile.speed = projectile_speed
	projectile.damage = projectile_damage
	get_tree().root.add_child(projectile) # Add to the scene tree
	
	
func start_fire_timer():
	can_shoot = false
	# Use a Timer node or create a temporary timer
	var timer = Timer.new()
	timer.wait_time = fire_rate
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect( func(): can_shoot = true)
