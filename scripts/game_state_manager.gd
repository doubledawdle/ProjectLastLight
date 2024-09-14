
extends Node

class_name GameState

signal update_timer(time_left: float)
signal change_background(cycle: DayCycle)

enum States {
	BEGINNING,
	PLAYING,
	SCAVENGING,
	BUILDING,
	PAUSED
}

enum DayCycle {
	DAY,
	EVENING,
	NIGHT,
}

var current_state
var current_cycle: DayCycle = DayCycle.DAY

var day_duration: float = 180.0 # Duration of the day phase in seconds
var evening_duration: float = 120.0 # Duration of the evening phase in seconds
var night_duration: float = 180.0 # Duration of the night phase in seconds


var day_timer: Timer 
var remaining_time: float = 0.0

var days_survived: int = 0

func get_cycle_name(cycle) -> String:
	match (cycle):
		DayCycle.DAY: 
			return "Day"
		DayCycle.EVENING:
			return "Evening"
		DayCycle.NIGHT:
			return "Night"
		
	return "Unknown Cycle"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# SET TO BEGINNING WHEN MAIN MENU EXISTS
	current_state = States.PLAYING



func _process(delta: float) -> void:
	#print(current_state)
	# TODO: probably shouldn't have input detected outside player
	if current_state != States.BEGINNING:
		if Input.is_action_just_pressed("ui_cancel") && current_state != States.PAUSED:
			enter_pause_state()
		elif Input.is_action_just_pressed("ui_cancel"):
			enter_playing_state()
			
			
	if remaining_time > 0:
		remaining_time -= delta  # Subtract elapsed time from remaining time
		emit_signal("update_timer", remaining_time)  # Emit the signal with remaining time
	else:
		emit_signal("update_timer", 0)  # Emit zero when time is up
		
			
func start_day_cycle() -> void:
	emit_signal("change_background", DayCycle.DAY)
	current_cycle = DayCycle.DAY
	start_phase(day_duration, "_on_day_phase_complete")
	print("day started")
	
# Starts the evening phase
func start_evening_phase() -> void:
	emit_signal("change_background", DayCycle.EVENING)
	current_cycle = DayCycle.EVENING
	start_phase(evening_duration, "_on_evening_phase_complete")
	
# Starts the night phase
func start_night_phase() -> void:
	emit_signal("change_background", DayCycle.NIGHT)
	current_cycle = DayCycle.NIGHT
	start_phase(night_duration, "_on_night_phase_complete")
	
	
func start_phase(duration: float, callback: String) -> void:
	if day_timer:
		day_timer.queue_free()
		
	day_timer = Timer.new()
	day_timer.wait_time = duration
	day_timer.one_shot = true
	day_timer.connect("timeout", Callable(self, callback))
	add_child(day_timer)
	day_timer.start()
	
	remaining_time = duration
	
# Called when the day phase is complete
func _on_day_phase_complete() -> void:
	print("Day phase complete, transitioning to evening.")
	start_evening_phase()

# Called when the evening phase is complete
func _on_evening_phase_complete() -> void:
	print("Evening phase complete, transitioning to night.")
	start_night_phase()

# Called when the night phase is complete
func _on_night_phase_complete() -> void:
	print("Night phase complete, starting a new day cycle.")
	days_survived += 1
	start_day_cycle() # Restart the cycle
	
func get_current_cycle() -> DayCycle:
	return current_cycle

func enter_beginning_state() -> void:
	current_state = States.BEGINNING


func enter_playing_state() -> void:
	current_state = States.PLAYING
	get_tree().paused = false


func enter_building_state() -> void:
	current_state = States.BUILDING


func enter_scavenging_state() -> void:
	current_state = States.SCAVENGING


func enter_pause_state() -> void:
	current_state = States.PAUSED
	get_tree().paused = true


func get_current_state() -> States:
	return current_state
	
func start_day_timer() -> void:
	day_timer = Timer.new()
	
