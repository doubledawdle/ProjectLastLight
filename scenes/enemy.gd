extends CharacterBody2D


const SPEED = 25.0
var isColliding := false

var health := 40

func _ready():
	GameStateManager.connect("increase_difficulty", Callable(self, "_increase_difficulty"))


func _physics_process(delta: float) -> void:
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !isColliding:
		var direction := Vector2(0,-1)
		velocity = direction * SPEED
	else: 
		velocity = Vector2.ZERO

	move_and_slide()
	
	


func _on_barricade_detection_area_entered(area: Area2D) -> void:
	isColliding = true


func _on_barricade_detection_area_exited(area: Area2D) -> void:
	isColliding = false

func take_damage(damage: int) -> void: 
	health -= damage
	print("Enemy took damage!")
	if health <= 0: 
		die()

func die() -> void: 
	queue_free()
	
func _increase_difficulty() -> void:
	print("difficulty increasing")
	if health == 100: 
		return 
	health += 20
