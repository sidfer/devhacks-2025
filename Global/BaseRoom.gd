extends Node2D


var clock_scene = preload("res://clock.tscn")

var timer_scene = preload("res://Scenes/UI/Timer.tscn")

func _ready():
	for i in range(3):  # Adjust the number of obstacles
		spawn_clock()
		
	for i in range(1):  # Adjust the number of obstacles
		spawn_time()


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
	


func spawn_time():
	var ctime = timer_scene.instance()  # Create an instance of the obstacle
	add_child(ctime)  # Add it to the scene

