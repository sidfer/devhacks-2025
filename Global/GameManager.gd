extends Node

var current_room : Node
var room_grid = Vector2(0, 0)  # Track player's grid position
var rooms = {}  # Stores generated rooms

func _ready():
	# Load the starting room
	load_room(Vector2(0, 0))

func load_room(grid_position: Vector2):
	# Freeze player during transition
	var player = get_tree().get_nodes_in_group("player")
	if player.size() > 0:
		player[0].can_move = false
	
	# Remove old room
	if current_room:
		current_room.queue_free()
	
	# Load/generate new room
	if not rooms.has(grid_position):
		generate_room(grid_position)
	
	current_room = rooms[grid_position]
	get_tree().current_scene.add_child(current_room)
	
	# Position player after room is fully loaded
	yield(get_tree().create_timer(0.1), "timeout")
	
	if player.size() > 0:
		var p = player[0]
		p.can_move = true
		var spawn = current_room.get_node_or_null("PlayerSpawn")
		if spawn:
			p.global_position = spawn.global_position
		else:
			push_error("Missing PlayerSpawn in room")
					
func generate_room(grid_position: Vector2):
	var room = preload("res://Scenes/Rooms/BaseRoom.tscn").instance()
	rooms[grid_position] = room
	
	# Randomly add treasure
	if randf() < 0.7:
		var treasure = preload("res://Scenes/Treasure.tscn").instance()
		room.add_child(treasure)
		treasure.position = Vector2(randi() % 500 + 100, randi() % 300 + 100)

func change_room(direction: String):
	var offset = Vector2.ZERO
	match direction:
		"up": offset.y -= 1
		"down": offset.y += 1
		"left": offset.x -= 1
		"right": offset.x += 1
	
	room_grid += offset
	load_room(room_grid)
