extends Control

func _ready():
	var restart_button = get_node("RestartButton")  
	restart_button.connect("pressed", self, "_on_restart_pressed")

func _on_restart_pressed():
	GameManager.reset()
	GlobalTimer.reset()
	get_tree().change_scene("res://MainWorld.tscn")  # Restart game
