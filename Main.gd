extends Node2D

var time_remaining = 30.0
var time_pickup_scene = preload("res://TimePickup.tscn")

func _ready():
	$SpawnTimer.start()

func _process(delta):
	time_remaining -= delta
	if time_remaining <= 0:
		game_over()
	update_ui()

func spawn_time_pickup():
	var pickup = time_pickup_scene.instance()
	add_child(pickup)
	pickup.connect("collected", self, "_on_TimePickup_collected")
	pickup.position = Vector2(
		get_viewport_rect().size.x + 100,
		rand_range(100, get_viewport_rect().size.y - 100)
	)

func _on_TimePickup_collected():
	time_remaining += 5.0  # Add 5 seconds per pickup

func update_ui():
	$UI/TimeLabel.text = "Time: %.1f" % time_remaining

func game_over():
	$SpawnTimer.stop()
	get_tree().paused = true
	$UI/GameOverLabel.visible = true


func _on_SpawnTimer_timeout():
	pass # Replace with function body.
