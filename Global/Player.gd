extends KinematicBody2D

const SPEED = 200
var current_speed = SPEED
var velocity = Vector2()
var can_move = true  # Movement control flag

func _ready():
	add_to_group("player")

func update_speed(multiplier):
	current_speed = SPEED * multiplier

func _physics_process(delta):
	if !can_move:
		return
		
	velocity = Vector2()
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * current_speed
	move_and_slide(velocity)
