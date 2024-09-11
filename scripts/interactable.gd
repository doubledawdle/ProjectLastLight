extends Area2D

var mouse_has_entered := false
var interacted := false
var selected := false

@export var is_oneshot_item := true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if mouse_has_entered:
		if event.is_action_pressed("interact"):
			print("player interacted")
			interacted = true
		else:
			interacted = false
			
		if event.is_action_pressed("select"):
			print("player selected")
			selected = true
		else:
			selected = false

func _on_mouse_entered() -> void:
	mouse_has_entered = true


func _on_mouse_exited() -> void:
	mouse_has_entered = false
