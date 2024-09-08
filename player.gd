extends Area2D


@export var SPEED = 100.0
var mouse_pos
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if Input.is_action_pressed("mouse_right"):
		position = mouse_pos
		position.clamp(Vector2.ZERO, screen_size)
		$AnimatedSprite2D.play("on_click")
		print("moving")
