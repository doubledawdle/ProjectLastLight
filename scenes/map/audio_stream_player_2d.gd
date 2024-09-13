extends AudioStreamPlayer2D

# Fading settings
@export var fade_duration = 0.2  # Duration of fade-in in seconds
@export var target_volume = 1.0  # Final volume after fade-in (make sure this is a float)
var current_time = 0.0  # Track fade time

var audio : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time
func _ready():
	self.volume_db = -80.0  # Start with volume muted (use float value)
	play()  # Start playing the audio
	current_time = 0.0  # Reset the fade-in timer
	set_process(true)  # Enable processing
	


func _process(delta):
	if current_time < fade_duration:
		current_time += delta
		# Calculate the new volume in dB (range: -80.0 to 0.0)
		var volume_db = lerp(-80.0, target_volume * 10.0, current_time / fade_duration)  # Ensure everything is treated as float
		self.volume_db = volume_db
	else:
		# Stop processing once the fade-in is complete
		set_process(false)
		self.volume_db = target_volume * 10.0  # Ensure final volume is set correctly (as float)
