extends Area2D

export(String) var direction = "left"
var can_trigger = true  # Cooldown flag

func _ready():
	connect("body_entered", self, "_on_Door_body_entered")
	
func _on_Door_body_entered(body):
	if body.is_in_group("player") && can_trigger:
		can_trigger = false
		GameManager.change_room(direction)
		# Reset cooldown after 0.5 seconds
		get_tree().create_timer(0.5).connect("timeout", self, "_reset_trigger")

func _reset_trigger():
	can_trigger = true
