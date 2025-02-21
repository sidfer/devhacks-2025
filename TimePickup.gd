extends Area2D

signal collected
var speed = 400  # Adjust speed as needed

func _process(delta):
	position.x -= speed * delta
	if position.x < -100:  # Remove when off-screen
		queue_free()

func _on_TimePickup_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("collected")
		queue_free()
