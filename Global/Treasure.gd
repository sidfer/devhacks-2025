extends Area2D  # Ensure this line is correct

func _on_Treasure_body_entered(body):
	if body.name == "Player":
		Global.add_score(10)
		Global.time_remaining += 15  # Add bonus time
		queue_free()  # Remove treasure
