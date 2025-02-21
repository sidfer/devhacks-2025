extends KinematicBody2D

var speed = 200  # Adjust movement speed

func _process(delta):
	var direction = Vector2.ZERO  # Start with no movement

	# Check input and set movement direction
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1

	# Normalize and apply movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()  # Prevent faster diagonal movement
		move_and_slide(direction * speed)
