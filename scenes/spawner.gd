extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_rate := 4.0
var spawn_timer: Timer
#var enemy_scene := preload("res://scenes/enemy.tscn")
var spawn_points := []




# Called when the node enters the scene tree for the first time.
func _ready():
	GameStateManager.connect("increase_difficulty", Callable(self, "_increase_difficulty"))
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
			
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_rate
	spawn_timer.connect("timeout", Callable(self, "_spawn_enemy"))
	add_child(spawn_timer)
	stop_spawning()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _spawn_enemy() -> void:
	
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)
	var spawn = spawn_points[randi() % spawn_points.size()]
	enemy_instance.position = spawn.position

func start_spawning() -> void:
	
	spawn_timer.start()
	
func stop_spawning() -> void:
	spawn_timer.stop()
	
func _increase_difficulty() -> void: 
	print(" enemy difficulty increasing")
	if spawn_rate == 2:
		return
	spawn_rate -= 1


#func _on_timer_timeout():
	#var spawn = spawn_points[randi() % spawn_points.size()]
	#
	#var shadow = enemy_scene.instantiate()
	#shadow.position = spawn.position
	#add_child(shadow)
