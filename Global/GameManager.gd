extends Node

var current_room : Node
var room_coordinates = Vector2(0, 0)  # Track player position in room grid
var rooms = {}  # Dictionary to track generated rooms

func _ready():
	# Autoload via Project Settings → Autoload tab
	pass

func change_room(direction):
	# Calculate new room position
	var offset = Vector2.ZERO
	match direction:
		"up": offset.y -= 1
		"down": offset.y += 1
		"left": offset.x -= 1
		"right": offset.x += 1
	
	room_coordinates += offset
	
	# Load new room if not already generated
	if not rooms.has(room_coordinates):
		generate_new_room(room_coordinates)
	
	# Transition to existing room
	var new_room = rooms[room_coordinates]
	get_tree().current_scene.add_child(new_room)
	
	# Move player to appropriate door position
	var player = get_tree().get_nodes_in_group("player")[0]
	player.global_position = new_room.get_node("PlayerSpawn").global_position

func generate_new_room(coords):
	var room = preload("res://Scenes/Rooms/BaseRoom.tscn").instance()
	rooms[coords] = room
	# Add treasure randomly
	if randf() < 0.7:  # 70% chance for treasure
		var treasure = preload("res://Scenes/Treasure.tscn").instance()
		room.add_child(treasure)
