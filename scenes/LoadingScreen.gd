extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var play_button : Button  # Reference to the play button

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button = get_node("PlayButton")  # Update the path to your PlayButton
	play_button.connect("pressed", self, "_on_play_button_pressed")


func _on_play_button_pressed():
	# Hide the loading screen when the button is pressed
	get_tree().change_scene("res://MainWorld.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
