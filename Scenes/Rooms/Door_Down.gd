extends Area2D

export(String) var direction = "down"


func _ready():
	connect("body_entered", self, "_on_Door_body_entered")

func _on_Door_body_entered(body):
	print("Door triggered by: ", body.name)
	if body.is_in_group("player"):
		GameManager.change_room(direction)

