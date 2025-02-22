extends Area2D


export var item_id = "5"  # Unique identifier for each collectible

func _ready():
	# Check if the item was already collected and remove it
	if GameManager.is_item_collected(item_id):
		queue_free()  # Remove item if it was already collected
	connect("body_entered", self, "_on_Collectible_body_entered")

func _on_Collectible_body_entered(body):
	if body.is_in_group("player"):  # Ensure it's the player collecting the item
		GameManager.mark_item_collected(item_id)
		queue_free()  # Remove the item from the scene
		print("Collected item:", item_id)
