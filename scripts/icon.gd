extends Sprite2D

@export var icon : Texture

var target_scale : Vector2 = Vector2(1.4, 1.4)
var default_scale : Vector2
var duration : float = 0.5
var bounce_distance : float = 20.0 # Distance to bounce left and right
var tween : Tween



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if icon != null: 
		texture = icon
		default_scale = scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	tween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", target_scale, duration).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(self, "rotation", -0.2, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", 0.2, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(duration / 2)
	tween.set_loops()
	
	
	


func _on_area_2d_mouse_exited() -> void:
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), duration)
	tween.tween_property(self, "rotation", 0, 0.3)
	
	
	
