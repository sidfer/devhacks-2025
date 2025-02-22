extends Area2D

# Signal to notify when the clock is eaten
signal clock_eaten

func _on_Clock_body_entered(body):
	# Check if the body is the player
	if body.is_in_group("player"):
		emit_signal("clock_eaten")
		queue_free()  # Remove the clock from the scene after it’s eaten
