extends CharacterBody2D


const SPEED = 25.0
var isColliding := false


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !isColliding:
		var direction := Vector2(0,-1)
		if direction:
			velocity.y = direction.y * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()


func _on_barricade_detection_area_entered(area: Area2D) -> void:
	isColliding = true


func _on_barricade_detection_area_exited(area: Area2D) -> void:
	isColliding = false
