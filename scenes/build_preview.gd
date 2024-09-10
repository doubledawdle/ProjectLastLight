extends Sprite2D
@export var blueprint_sprite : Sprite2D
@export var game_sprite : Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $InventoryItem.is_preview:
		texture = blueprint_sprite.texture
	else:
		texture = game_sprite.texture
