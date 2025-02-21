extends Control

func _on_RetryButton_pressed():
	Global.reset_stats()
	get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
