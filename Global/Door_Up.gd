extends Area2D

export(String) var direction = "up"

func _ready():
	# Connect the signal automatically (no need for manual connection)
	connect("body_entered", self, "_on_Door_body_entered")

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		# Call the GameManager to handle the room change
		GameManager.change_room(direction)
