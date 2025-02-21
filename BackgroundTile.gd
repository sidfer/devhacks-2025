extends Node2D

func _ready():
	# Center the background in the viewport
	position = get_viewport_rect().size / 2
