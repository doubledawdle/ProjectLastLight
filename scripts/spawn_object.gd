extends Button

@export var object_to_spawn: PackedScene
#@onready var game_state_manager = $"../../GameStateManager"
var obj

func _ready() -> void:
	if object_to_spawn == null:
		disabled = true
	else:
		obj = load(object_to_spawn.resource_path)
		#icon = obj

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_pressed && object_to_spawn != null:
		var instance: Node2D = obj.instantiate()
		get_node("/root").add_child(instance)
		# Hacky. to prevent obj spawning at 0,0 for one frame. No time to fix
		instance.position = Vector2(-9999,-9999)
		print("instantiating")
		#game_state_manager.enter_building_state()
