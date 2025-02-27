extends Node

var loading_screen : Control  # Reference to the loading screen
var play_button : Button  # Reference to the play button

var current_room : Node
var room_grid = Vector2(0, 0)  # Track player's grid position
var rooms = {}  # Stores generated rooms

var collected_items = {}  # Dictionary to track collected items
var TOTAL_ITEMS = 5;

func mark_item_collected(item_id):
	collected_items[item_id] = true  # Mark this item as collected
	check_win_condition()

func is_item_collected(item_id):
	return collected_items.get(item_id, false)  # Return true if collected

func check_win_condition():
	if collected_items.size() >= TOTAL_ITEMS:
		win_game();

func win_game():
	print("Congratulations! You won!")
	get_tree().change_scene("res://WonGame.tscn")
	emit_signal("game_won")  # Notify UI or trigger a win screen


#func _ready():
#	# Load the starting room
#	load_room(Vector2(0, 0))

# In GameManager.gd
func reset():
	var time = get_tree().get_nodes_in_group("timer")
	current_room = null
	room_grid = Vector2(0, 0)
	rooms = {}

func _ready():
	# Load the loading screen (make sure the loading screen scene is in your res:// folder)
	loading_screen = preload("res://Scenes/LoadingScreen.tscn").instance()
	
	# Add the loading screen to the scene tree (it'll be on top of the game content)
	# add_child(loading_screen)
	
	# Setup the play button
#	play_button = loading_screen.get_node("PlayButton")
#	play_button.connect("pressed", self, "_on_play_button_pressed")
#
	# Optionally, set up other parts of the game manager (if needed)
	# e.g., set initial room state, freeze player, etc.

#func _on_play_button_pressed():
#	# Hide the loading screen when the button is pressed
#	loading_screen.queue_free()
#	# Continue running the game logic (e.g., loading the first room)
#	print("Play button pressed. Starting the game.")
	

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
		var room_name = GameManager.current_room.name  
		print("Freeing old room: ", room_name)
		GameManager.current_room.queue_free()
		GameManager.current_room = null  # Clear the reference



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
	# yield(get_tree().create_timer(0.3), "timeout")  
	if player.size() > 0:
		var p = player[0]
		p.can_move = true
		# yield(get_tree().create_timer(0.3), "timeout")
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
