extends Node2D  

func _ready():  
	# Load the starting room (BaseRoom)  
	GameManager.load_room(Vector2(0, 0))  
