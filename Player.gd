extends Area2D

var speed = 500  # Adjust speed as needed

func _process(delta):
	var input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	position.x += input * speed * delta
	# Keep player within screen bounds
	position.x = clamp(position.x, 50, get_viewport_rect().size.x - 50)
