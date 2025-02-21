extends Node2D

var time_remaining = 30.0
var time_pickup_scene = preload("res://TimePickup.tscn")

var obstacle_scene = preload("res://Obstacle.tscn")

func _ready():
	randomize()
	$Player.position = Vector2(
		get_viewport_rect().size.x / 2,
		get_viewport_rect().size.y - 100
	)
	$SpawnTimer.start()
 
 # Spawn obstacles at random positions
	for i in range(5):  # Adjust the number of obstacles
		spawn_obstacle()

func spawn_obstacle():
	var obstacle = obstacle_scene.instance()  # Create an instance of the obstacle
	add_child(obstacle)  # Add it to the scene

	# Randomly position it within the game area
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y

	obstacle.position = Vector2(
		rand_range(50, screen_width - 50),  # Random X, avoiding edges
		rand_range(50, screen_height - 50)  # Random Y, avoiding the bottom area
	)
	
func _process(delta):
	time_remaining -= delta
	if time_remaining <= 0:
		game_over()
	update_ui()

func spawn_time_pickup():
	var pickup = time_pickup_scene.instance()
	add_child(pickup)
	pickup.connect("collected", self, "_on_TimePickup_collected")
	# Spawn at a random X position ABOVE the screen
	pickup.position = Vector2(
		rand_range(50, get_viewport_rect().size.x - 50),  # Random X
		-100  # Start above the screen
	)

func _on_TimePickup_collected():
	time_remaining += 5.0  # Add 5 seconds per pickup

func update_ui():
	$UI/TimeLabel.text = "Time: %.1f" % time_remaining

func game_over():
	$SpawnTimer.stop()
	get_tree().paused = true
	$UI/GameOverLabel.visible = true


func _on_SpawnTimer_timeout():
	pass # Replace with function body.
