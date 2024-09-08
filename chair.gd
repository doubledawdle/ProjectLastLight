extends AnimatedSprite2D

func _ready() -> void:
	print("spawned")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Interactable.selected:
		print("user selected chair")
