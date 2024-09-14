extends Sprite2D
@export var blueprint_icon : Texture
@export var icon : Texture

# should be in a take damage component. no time
var enemyDetected := false
@export var hitsBeforeDeath := 5
var currentHitsTaken := 0
var timeToKill := 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $InventoryItem.is_preview:
		texture = blueprint_icon
	else:
		texture = icon

	if enemyDetected:
		currentHitsTaken += 1
		#print(currentHitsTaken)
		
	if currentHitsTaken >= hitsBeforeDeath * timeToKill:
		die()

func _on_enemy_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		print("enemy entered", area)
		enemyDetected = true

func _on_enemy_detection_area_exited(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		print("enemy exited", area)
		enemyDetected = false

func die() -> void:
	queue_free()
