extends Camera2D


@export var SPEED = 100.0
@export var map_scene: PackedScene
#var mouse_pos
#var screen_size
var obj
var instance: Node2D
@onready var game_state: GameState = $"../GameStateManager"

func _ready() -> void:
	#screen_size = get_viewport_rect().size
	if map_scene != null:
		obj = load(map_scene.resource_path)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Map"):
		if instance == null:
			game_state.enter_scavenging_state()
			instance = obj.instantiate()
			get_node("/root").add_child(instance)
		else:
			game_state.enter_playing_state()
			get_node(instance.get_path()).queue_free()
	#mouse_pos = get_global_mouse_position()
	#if Input.is_action_pressed("mouse_right"):
		#position = mouse_pos
		#position.clamp(Vector2.ZERO, screen_size)
		#$AnimatedSprite2D.play("on_click")
		#print("moving")
	#if game_state_manager.current_state == 3:
		#print("building")
		
