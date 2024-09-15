extends Area2D

var damage = 10
var damage_timer: Timer = null
var is_enemy_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_timer = Timer.new()
	damage_timer.wait_time = 0.2  # Time between each damage application
	damage_timer.one_shot = false
	damage_timer.connect("timeout", Callable(self, "_apply_damage"))
	add_child(damage_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func follow_mouse() -> void:
	global_position = get_global_mouse_position()


func _on_body_entered(body):
	if body.is_in_group("Monsters"):
		is_enemy_inside = true
		damage_timer.start()


func _on_body_exited(body):
	if body.is_in_group("Monsters"):
		is_enemy_inside = false
		damage_timer.stop()
		
func _apply_damage() -> void: 
	if is_enemy_inside: 
		for body in get_overlapping_bodies():
			if body.is_in_group("Monsters"):
				body.take_damage(damage)
