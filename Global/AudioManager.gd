extends Node  # Autoload script

var music_player = AudioStreamPlayer.new()
var mps = preload("res://audio/cave themeb4.ogg")

func _ready(): # Rep/lace with your file
	music_player.stream = mps
	add_child(music_player)
	music_player.play()
