extends KinematicBody2D

const SPEED = 200
var velocity = Vector2()

func _physics_process(delta):
	velocity = Vector2()
	# Input handling
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * SPEED
	move_and_slide(velocity)



