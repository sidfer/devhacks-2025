Write the Script
Replace the default script with this:

gdscript
Copy
extends Node2D

# Reference to the labels
onready var time_label = $TimeLabel
onready var score_label = $ScoreLabel

func _ready():
	# Call update_hud() whenever the Global variables change
	Global.connect("time_updated", self, "update_hud")
	Global.connect("score_updated", self, "update_hud")
	update_hud()  # Initialize the HUD

func update_hud():
	time_label.text = "Time: %d" % Global.time_remaining
	score_label.text = "Score: %d" % Global.score
