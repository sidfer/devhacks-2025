extends Area2D

export(String) var direction = "right"


func _ready():
	connect("body_entered", self, "_on_Door_body_entered")

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		print("Door triggered by: ", body.name)
		GameManager.change_room(direction)

