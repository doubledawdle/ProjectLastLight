extends Node2D

var is_preview := true
@export var preview_offset := Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_preview:
		if Input.is_action_just_pressed("ui_cancel"):
			get_parent().queue_free()
		get_parent().position = get_viewport().get_mouse_position() - preview_offset * delta
	
	if $Interactable.selected:
		is_preview = false
		print("user selected")
