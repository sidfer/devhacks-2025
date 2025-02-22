extends Control

func _on_StartButton_pressed():
	Global.reset_stats()
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
