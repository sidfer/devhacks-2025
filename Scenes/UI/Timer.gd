extends Label  # Assuming the Timer is displayed using a Label

var time_remaining = GlobalTimer.time_remaining  # Initial time in seconds
var timer = null

func _ready():
	timer = Timer.new()  # Create a new Timer node
	add_child(timer)  # Add it to this scene
	timer.wait_time = 1.0  # Set to decrease every second
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", self, "_on_Timer_timeout")  # Connect the signal
	timer.start()

	update_timer_display()  # Update display initially

func _process(delta):
	var label = $Label  # Assuming a Label is present in the Timer scene
	if label:
		label.text = "Time Remaining: " + str(GlobalTimer.time_remaining)


func _on_Timer_timeout():
	time_remaining -= 1
	update_timer_display()
	
	if time_remaining <= 0:
		timer.stop()
		game_over()  # Call game over function (define in your game logic)

func update_timer_display():
	text = "Time: " + str(time_remaining)

func game_over():
	get_tree().reload_current_scene()  # Example: Restart the scene when time runs out
