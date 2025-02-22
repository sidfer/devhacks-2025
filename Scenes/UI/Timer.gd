extends Label  # The Timer is displayed using a Label

func _ready():
	# Set initial time
	update_timer_display(GlobalTimer.time_remaining)
	
	# Connect to GlobalTimer signal to update UI instantly
	GlobalTimer.connect("time_updated", self, "_on_time_updated")

func _on_time_updated(new_time):
	update_timer_display(new_time)

func update_timer_display(time):
	text = "Time Remaining: " + str(time)  # Update Label text instantly
