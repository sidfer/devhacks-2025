extends Node

func _ready():
	# Create all rooms dynamically or set up specific rooms
	create_room(Vector2(-1, -1))
	create_room(Vector2(0, -1))
	create_room(Vector2(1, -1))
	create_room(Vector2(-1, 0))  # Center room
	create_room(Vector2(1, 0))
	create_room(Vector2(-1, 1))
	create_room(Vector2(0, 1))
	create_room(Vector2(1, 1))

# Function to create and position rooms
func create_room(position: Vector2):
	var room = Node2D.new()
	room.name = "Room_%d_%d" % [position.x, position.y]
	add_child(room)

	# Add ColorRect or Sprite as a background (for now using ColorRect)
	var color_rect = ColorRect.new()
	color_rect.rect_min_size = Vector2(500, 500)  # Size of the room
	color_rect.color = Color(0.5, 0.5, 1.0)  # Light blue color
	room.add_child(color_rect)

	# Position the room
	room.position = position * 500  # Spacing between rooms

	# You can later add specific scripts for each room if needed.
	# For example: room.set_script(load("res://RoomScript.gd"))
