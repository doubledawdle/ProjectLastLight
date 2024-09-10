extends Node

enum GameState {
	BEGINNING,
	PLAYING,
	BUILDING,
	PAUSE
}

var current_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = GameState.BEGINNING


func enter_beginning_state() -> void:
	current_state = GameState.BEGINNING


func enter_playing_state() -> void:
	current_state = GameState.PLAYING


func enter_building_state() -> void:
	current_state = GameState.BUILDING


func enter_pause_state() -> void:
	current_state = GameState.PAUSE
