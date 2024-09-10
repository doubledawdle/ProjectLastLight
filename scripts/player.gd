extends Camera2D


@export var SPEED = 100.0
var mouse_pos
var screen_size
#@onready var game_state_manager: Node = $"../GameStateManager"

func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	pass
	#mouse_pos = get_global_mouse_position()
	#if Input.is_action_pressed("mouse_right"):
		#position = mouse_pos
		#position.clamp(Vector2.ZERO, screen_size)
		#$AnimatedSprite2D.play("on_click")
		#print("moving")
	#if game_state_manager.current_state == 3:
		#print("building")
		
