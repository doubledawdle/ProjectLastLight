
extends Node

class_name GameState

enum States {
	BEGINNING,
	PLAYING,
	SCAVENGING,
	BUILDING,
	PAUSED
}

var current_state

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
