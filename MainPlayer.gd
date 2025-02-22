extends KinematicBody2D

var normal_speed = 200
var slow_speed = 75
var speed = normal_speed  # Current speed
var slow_obstacle_count = 0  # Track overlapping slow obstacles

func _ready():
	# Connect to the Area2D signals (assuming the player has an Area2D child named "Hitbox")
	$Hitbox.connect("area_entered", self, "_on_Hitbox_area_entered")
	$Hitbox.connect("area_exited", self, "_on_Hitbox_area_exited")

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	# Handle input
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1

	# Normalize and move
	direction = direction.normalized()
	move_and_slide(direction * speed)

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
			speed = normal_speed  # Restore normal speed
