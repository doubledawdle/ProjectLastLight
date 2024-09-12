extends Sprite2D

@export var icon : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if icon != null:
		texture = icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
