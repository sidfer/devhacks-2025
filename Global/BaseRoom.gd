extends Node2D

var obstacle_scene = preload("res://Obstacle.tscn")
var slow_obstacle_scene = preload("res://Slow.tscn")

var clock_scene = preload("res://clock.tscn")

func _ready():

 # Spawn obstacles at random positions
	for i in range(5):  # Adjust the number of obstacles
		spawn_obstacle()

	 # Spawn slow obstacles at random positions
	for i in range(3):  # Adjust the number of obstacles
		spawn_slow_obstacle()

	for i in range(3):  # Adjust the number of obstacles
		spawn_clock()


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



func spawn_slow_obstacle():
	var slow_obstacle = slow_obstacle_scene.instance()  # Create an instance of the obstacle
	add_child(slow_obstacle)  # Add it to the scene

	# Randomly position it within the game area
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y

	slow_obstacle.position = Vector2(
		rand_range(50, screen_width - 50),  # Random X, avoiding edges
		rand_range(50, screen_height - 50)  # Random Y, avoiding the bottom area
	)	
	
	
func spawn_clock():
	var clocks = clock_scene.instance()  # Create an instance of the obstacle
	clocks.add_to_group("clock")  # Add to group
	add_child(clocks)  # Add it to the scene

	# Randomly position it within the game area
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y

	clocks.position = Vector2(
		rand_range(50, screen_width - 50),  # Random X, avoiding edges
		rand_range(50, screen_height - 50)  # Random Y, avoiding the bottom area
	)
	

