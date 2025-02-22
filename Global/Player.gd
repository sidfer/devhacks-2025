extends KinematicBody2D

const NORMAL_SPEED = 200
var slow_speed = 75
var speed = NORMAL_SPEED  # Current speed
var slow_obstacle_count = 0 
var player_direction= "Up"

var velocity = Vector2()
var can_move = true  # Movement control flag

func _ready():
	add_to_group("player")

	$Hitbox.connect("area_entered", self, "_on_Hitbox_area_entered")
	$Hitbox.connect("area_exited", self, "_on_Hitbox_area_exited")



func _physics_process(delta):
	if !can_move:
		return
	
	# Get horizontal input strength (left and right)
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	# Get vertical input strength (up and down)
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Normalize the velocity so diagonal movement isn't faster
	velocity = velocity.normalized() * speed
	
	# Handle animations based on movement
	if velocity.length() > 0:  # Player is moving
		if velocity.x > 0:  # Moving right
			$SpriteRight.play("RightWalk")
			player_direction= "Right"
		elif velocity.x < 0:  # Moving left
			$SpriteRight.play("LeftWalk")
			player_direction= "Left"
		elif velocity.y > 0:  # Moving down
			$SpriteRight.play("DownWalk")
			player_direction= "Down"
		elif velocity.y < 0:  # Moving up
			$SpriteRight.play("UpWalk")
			player_direction= "Up"
	else:  # Player is idle
		# Play the idle animation based on the last direction
		if player_direction == "Right":
			$SpriteRight.play("IdleRight")
		elif player_direction == "Left":    
			$SpriteRight.play("IdleLeft")
		elif player_direction == "Down":
			$SpriteRight.play("IdleDown")
		elif player_direction == "Up":
			$SpriteRight.play("IdleUp")
		
	
	# Move the player
	move_and_slide(velocity)


# Called when entering a slow obstacle area
# Called when entering a slow obstacle area
func _on_Hitbox_area_entered(area):
	if area.is_in_group("slow_obstacles"):
		slow_obstacle_count += 1
		speed = slow_speed  # Apply slow speed
	elif area.is_in_group("clock"):  # If colliding with a clock
		area.queue_free()  # Remove the clock from the scene


# Called when exiting a slow obstacle area
func _on_Hitbox_area_exited(area):
	if area.is_in_group("slow_obstacles"):
		slow_obstacle_count -= 1
		if slow_obstacle_count == 0:
			speed = NORMAL_SPEED  # Restore normal speed



