extends Node

signal time_updated(time)  # Signal to notify when time changes

var time_remaining = 10.0
var timer = null

func _ready():
	if timer == null:  # Ensure only one timer exists
		timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.autostart = true
		timer.one_shot = false
		timer.connect("timeout", self, "_on_Timer_timeout")
		timer.start()

func _on_Timer_timeout():
	time_remaining -= 1
	emit_signal("time_updated", time_remaining)  # Notify UI
	if time_remaining <= 0:
		timer.stop()
		game_over()

func add_time(seconds: int):
	time_remaining += seconds
	emit_signal("time_updated", time_remaining)  # Notify UI
	print("Time increased by ", seconds, " seconds! New time: ", time_remaining)

func game_over():
	print("Game Over!")  # Replace with your game-over logic
	get_tree().change_scene("res://GameOver.tscn")  # Switch to game-over screen

