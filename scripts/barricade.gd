extends Sprite2D
@export var blueprint_icon : Texture
@export var icon : Texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $InventoryItem.is_preview:
		texture = blueprint_icon
	else:
		texture = icon
