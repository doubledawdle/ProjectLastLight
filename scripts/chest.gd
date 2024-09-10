extends AnimatedSprite2D

var play_anim := true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Interactable.interacted && play_anim:
		play("chest_open")


func _on_animation_finished() -> void:
	play_anim = false
