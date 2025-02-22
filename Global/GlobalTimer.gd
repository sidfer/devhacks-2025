extends Node  # Singleton script (Autoload)

var time_remaining = 30.0
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
	if time_remaining <= 0:
		timer.stop()
		game_over()

func game_over():
	print("Game Over!")  # Replace with your game-over logic
