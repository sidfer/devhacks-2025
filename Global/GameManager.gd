extends Node

var current_room : Node
var room_grid = Vector2(0, 0)  # Track player's grid position
var rooms = {}  # Stores generated rooms

func _ready():
	# Load the starting room
	load_room(Vector2(0, 0))

func load_room(grid_position: Vector2, from_direction: String=""):  
	print("Loading room at grid position: ", grid_position, " from direction: ", from_direction)
	
	# Freeze the global player  
	var player = get_tree().get_nodes_in_group("player")  
	print("Player nodes found: ", player.size())
	
	if player.size() > 0:  
		player[0].can_move = false  
		print("Player frozen: ", player[0].name)
	
	# Remove the old room from RoomContainer  
	if GameManager.current_room:  
		print("Freeing old room: ", GameManager.current_room.name)
		GameManager.current_room.queue_free()  

	# Load/generate the new room  
	if not GameManager.rooms.has(grid_position):  
		print("Generating new room at: ", grid_position)
		GameManager.generate_room(grid_position)  

	# Instance the new room and add it to RoomContainer  
	var room_instance = GameManager.rooms[grid_position].instance()  
	print("Instanced room: ", room_instance.name)
	get_node("/root/MainWorld/RoomContainer").add_child(room_instance)  
	GameManager.current_room = room_instance  

	# Reposition the player after a small delay  
	yield(get_tree().create_timer(0.1), "timeout")  
	if player.size() > 0:
		var p = player[0]
		p.can_move = true
		print("Player unfrozen: ", p.name)
		
		# Use direction-specific spawn point
		var spawn_name = "Spawn_" + from_direction.capitalize() if from_direction != "" else "PlayerSpawn"
 # Use direction-specific spawn point


	# Special case for vertical directions:
		if from_direction == "up":
			spawn_name = "Spawn_Down"  # Entering from "up" → spawn at "Spawn_Down"
		elif from_direction == "down":
			spawn_name = "Spawn_Up"    # Entering from "down" → spawn at "Spawn_Up"
		print("Looking for spawn point: ", spawn_name)
		
		var spawn = current_room.get_node_or_null(spawn_name)
		if spawn:
			print("Found spawn point at: ", spawn.global_position)
			p.global_position = spawn.global_position
		else:
			push_error("Missing spawn: " + spawn_name)
func generate_room(grid_position: Vector2):
	var room_scene_path: String
	match grid_position:
		Vector2(0,0):
			print("loading base room")
			room_scene_path = "res://Scenes/Rooms/BaseRoom.tscn"
		Vector2(1,0):
			print("loading right room")
			room_scene_path = "res://Scenes/Rooms/RightRoom.tscn"
		Vector2(-1,0):
			print("loading left room")
			room_scene_path = "res://Scenes/Rooms/LeftRoom.tscn"
		Vector2(0,1):
			print("loading down room")
			room_scene_path = "res://Scenes/Rooms/DownRoom.tscn"
		Vector2(0,-1):
			print("loading up room")
			room_scene_path = "res://Scenes/Rooms/UpRoom.tscn"
		_:
			push_error("Invalid grid position: %s" % grid_position)
			return

	var room_scene = load(room_scene_path)
	rooms[grid_position] = room_scene

func change_room(direction: String):
	print("Changing room in direction: ", direction)
	
	var offset = Vector2.ZERO
	match direction:
		"up": offset.y -= 1
		"down": offset.y += 1
		"left": offset.x -= 1
		"right": offset.x += 1

	var new_grid = room_grid + offset
	print("New grid position: ", new_grid)

	# Define allowed grid positions
	var allowed_positions = [
		Vector2(0,0),   # Center
		Vector2(1,0),   # Right
		Vector2(-1,0),  # Left
		Vector2(0,1),   # Down
		Vector2(0,-1)   # Up
	]

	if new_grid in allowed_positions:
		print("New grid position is valid")
		room_grid = new_grid
		load_room(room_grid, direction)
	else:
		print("Movement blocked: Invalid grid position")
