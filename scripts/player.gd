extends Camera2D


@export var SPEED = 100.0
@export var map_scene: PackedScene
#var mouse_pos
#var screen_size
var obj
var instance: Node2D
#@onready var game_state: GameState = $"../GameStateManager"
@onready var light_area = preload("res://scenes/light_area.tscn")
@onready var game_over_scene = preload("res://scenes/game_over.tscn")
var active_light = null

var fuel_drain_rate: float = 1.0

# should be in a take damage component. no time
var enemyDetected := false
@export var hitsBeforeDeath := 5
var currentHitsTaken := 0
var timeToKill := 100

func _ready() -> void:
	#screen_size = get_viewport_rect().size
	if map_scene != null:
		obj = load(map_scene.resource_path)


func _process(delta: float) -> void:
	if GameStateManager.get_current_cycle() == GameStateManager.DayCycle.DAY:
		if Input.is_action_just_pressed("Map"):
			if instance == null:
				GameStateManager.enter_scavenging_state()
				instance = obj.instantiate()
				get_node("/root").add_child(instance)
			else:
				GameStateManager.enter_playing_state()
				get_node(instance.get_path()).queue_free()
	else:
		if instance != null:
			GameStateManager.enter_playing_state()
			get_node(instance.get_path()).queue_free()
			
	if Input.is_action_just_pressed("Light") and ResourceInventory.get_resource_amount(ResourceInventory.ResourceType.FUEL) != 0:
		print("Light button pressed")
		if active_light == null:
			active_light = light_area.instantiate()
			get_node("/root").add_child(active_light)
		active_light.global_position = get_global_mouse_position()
		
	if active_light:
		active_light.follow_mouse()
		
		drain_fuel(delta)
		
		if ResourceInventory.get_resource_amount(ResourceInventory.ResourceType.FUEL) == 0:
			turn_off_light()
		
	if Input.is_action_just_released("Light") and active_light:
		active_light.queue_free()
		active_light = null
	#mouse_pos = get_global_mouse_position()
	#if Input.is_action_pressed("mouse_right"):
		#position = mouse_pos
		#position.clamp(Vector2.ZERO, screen_size)
		#$AnimatedSprite2D.play("on_click")
		#print("moving")
	#if game_state_manager.current_state == 3:
		#print("building")
		
	if enemyDetected:
		currentHitsTaken += 1
		#print(currentHitsTaken)
		
	if currentHitsTaken >= hitsBeforeDeath * timeToKill:
		die()
		
func drain_fuel(delta: float) -> void:
	var fuel = ResourceInventory.get_resource_amount(ResourceInventory.ResourceType.FUEL)
	
	if fuel <= 0:
		turn_off_light()
		return
		
	var fuel_to_drain = fuel_drain_rate * delta

	if fuel_to_drain > fuel:
		fuel_to_drain = fuel
		# Only remove the amount of fuel needed for this frame
	ResourceInventory.remove_resource(ResourceInventory.ResourceType.FUEL, fuel_to_drain)
		
	
	
		
func turn_off_light() -> void:
	if active_light:
		active_light.queue_free()
		active_light = null
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		print("enemy entered", area)
		enemyDetected = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		print("enemy exited", area)
		enemyDetected = false

func die() -> void:
	print("GAME OVER")
	GameStateManager.enter_beginning_state()
	GameStateManager.end_game()
	var game_over_instance = game_over_scene.instantiate()
	get_node("/root").add_child(game_over_instance)
