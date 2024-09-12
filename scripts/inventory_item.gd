extends Node2D

var is_preview := true
@export var preview_offset := Vector2.ZERO
@export_category("Required")
@export var interactable: Interactable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interactable != null:
		if is_preview:
			if interactable.interacted:
				get_parent().queue_free()
			get_parent().position = get_viewport().get_mouse_position() - preview_offset * delta
		
		if interactable.selected:
			is_preview = false
