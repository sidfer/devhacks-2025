extends KinematicBody2D

const NORMAL_SPEED = 200
var slow_speed = 75
var speed = NORMAL_SPEED  # Current speed
var slow_obstacle_count = 0 

var velocity = Vector2()
var can_move = true  # Movement control flag

func _ready():
	add_to_group("player")


func _physics_process(delta):
	if !can_move:
		return
		
	velocity = Vector2()
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * NORMAL_SPEED
	move_and_slide(velocity)


# Called when entering a slow obstacle area
func _on_Hitbox_area_entered(area):
	if area.is_in_group("slow_obstacles"):
		slow_obstacle_count += 1
		speed = slow_speed  # Apply slow speed

# Called when exiting a slow obstacle area
func _on_Hitbox_area_exited(area):
	if area.is_in_group("slow_obstacles"):
		slow_obstacle_count -= 1
		if slow_obstacle_count == 0:
			speed = NORMAL_SPEED  # Restore normal speed



