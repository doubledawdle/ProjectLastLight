extends Sprite2D
@export var blueprint_icon : Texture
@export var icon : Texture

# should be in a take damage component. no time
var enemyDetected := false
@export var hitsBeforeDeath: int
@export var barricade_level: int
var currentHitsTaken := 0
var timeToKill := 100

func _ready():
	GameStateManager.connect("increase_difficulty", Callable(self, "_increase_difficulty"))
	

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
	
func _increase_difficulty() -> void:
	print("barricade difficulty increasing")
	if barricade_level == 1: 
		if hitsBeforeDeath == 5:
			return
		hitsBeforeDeath -= 2
	elif barricade_level == 2:
		if hitsBeforeDeath == 10:
			return
		hitsBeforeDeath -= 2
	else: 
		if hitsBeforeDeath == 30:
			return 
		hitsBeforeDeath -= 2
