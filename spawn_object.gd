extends Button

@export var spawn_object: PackedScene
@export var spawn_pos: Vector2
var obj

func _ready() -> void:
	if spawn_object != null:
		print("loading spawn obj")
		obj = load(spawn_object.resource_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed && spawn_object != null:
		var instance: Node2D = obj.instantiate()
		instance.position = Vector2(spawn_pos)
		get_node("/root").add_child(instance)
