extends Node2D

var scroll_speed = 200  # Match this to collectible speed

func _process(delta):
	position.y += scroll_speed * delta  # Move downward
	# Reset position when off-screen
	if position.y > get_viewport_rect().size.y:
		position.y = -get_viewport_rect().size.y  # Move back to the top
