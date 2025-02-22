extends Node

signal time_updated
signal score_updated

var time_remaining = 60
var current_level = 1
var score = 0
var timer : Timer

func _ready():
	timer = Timer.new()  # Create a new Timer
	add_child(timer)     # Add it as a child of Global
	timer.wait_time = 1.0  # Set the interval to 1 second
	timer.connect("timeout", self, "_on_Timer_timeout")  # Connect the timeout signal
	timer.start()  # Start the timerown every second

func _on_Timer_timeout():
	time_remaining -= 1
	emit_signal("time_updated")  # Notify HUD
	if time_remaining <= 0:
		game_over()

func add_score(value):
	score += value
	emit_signal("score_updated")  # Notify HUD

# Add to existing Global.gd
func game_over():
	get_tree().change_scene("res://Scenes/UI/GameOver.tscn")
	reset_stats()

func reset_stats():
	time_remaining = 60
	score = 0
	current_level = 1
	

func reset_timer():
	time_remaining = 60  # Reset to initial value
	timer.stop()  # Stop the existing timer
	timer.start()  # Restart the timer
	emit_signal("time_updated")  # Force UI update

func check_level_progression():
	if score >= current_level * 50:  # Example: 50 points per level
		current_level += 1
		apply_level_mechanics()

func apply_level_mechanics():
	match current_level:
		2:
			# Speed boost
			get_tree().call_group("player", "update_speed", 1.5)
		3:
			# Bigger rooms
			get_tree().call_group("room_generator", "increase_room_size")
