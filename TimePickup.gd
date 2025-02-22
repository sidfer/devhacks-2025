extends Area2D

signal collected
var speed = 200  # Adjust speed as needed

func _process(delta):
	position.y += speed * delta  # Move downward
	# Remove when off-screen (bottom of the screen)
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()

func _on_TimePickup_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("collected")
		queue_free()
