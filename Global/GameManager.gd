extends Node

var current_room : Node
var room_grid = Vector2(0, 0)  # Track player's grid position
var rooms = {}  # Stores generated rooms

func _ready():
	# Load the starting room
	load_room(Vector2(0, 0))

func load_room(grid_position: Vector2):  
	# Freeze the global player  
	var player = get_tree().get_nodes_in_group("player")  
	if player.size() > 0:  
		player[0].can_move = false  

	# Remove the old room from RoomContainer  
	if GameManager.current_room:  
		GameManager.current_room.queue_free()  

	# Load/generate the new room  
	if not GameManager.rooms.has(grid_position):  
		GameManager.generate_room(grid_position)  

	# Instance the new room and add it to RoomContainer  
	var room_instance = GameManager.rooms[grid_position].instance()  
	get_node("/root/MainWorld/RoomContainer").add_child(room_instance)  
	GameManager.current_room = room_instance  

	# Reposition the player after a small delay  
	yield(get_tree().create_timer(0.1), "timeout")  
	if player.size() > 0:  
		var p = player[0]  
		p.can_move = true  
		var spawn = GameManager.current_room.get_node_or_null("PlayerSpawn")  
		if spawn:  
			p.global_position = spawn.global_position  
		else:  
			push_error("Missing PlayerSpawn in room")  
			
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
	var offset = Vector2.ZERO
	match direction:
		"up": offset.y -= 1
		"down": offset.y += 1
		"left": offset.x -= 1
		"right": offset.x += 1

	var new_grid = room_grid + offset

	# Define allowed grid positions
	var allowed_positions = [
		Vector2(0,0),   # Center
		Vector2(1,0),   # Right
		Vector2(-1,0),  # Left
		Vector2(0,1),   # Down
		Vector2(0,-1)   # Up
	]

	if new_grid in allowed_positions:
		room_grid = new_grid
		load_room(room_grid)
	else:
		# Optional: Play error sound or show feedback
		print("Movement blocked")
