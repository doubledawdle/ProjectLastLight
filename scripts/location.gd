extends Sprite2D

@export var icon : Texture

var target_scale : Vector2 = Vector2(0.3, 0.3)
var default_scale : Vector2
var duration : float = 0.2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if icon != null:
		texture = icon
	default_scale = Vector2(0.185, 0.185)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_interactable_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	if $Interactable.mouse_has_entered:
		print("scale", self.scale)
		
		tween.tween_property(self, "modulate", Color.RED, 1)
		tween.tween_property(self, "scale", target_scale, duration)
		tween.tween_property(self, "scale", Vector2(1, 1), duration)
	else: 
		print("Im in the else")
		tween.tween_property(self, "scale", Vector2(default_scale), duration)
	
