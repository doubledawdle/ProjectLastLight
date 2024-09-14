extends Area2D

var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func follow_mouse() -> void:
	global_position = get_global_mouse_position()


func _on_body_entered(body):
	if body.is_in_group("monsters"):
		body.take_damage(damage)
