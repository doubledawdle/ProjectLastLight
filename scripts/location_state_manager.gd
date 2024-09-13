
extends Node

class_name LocationState

var timer: Timer = null # ref for the timer 
var resource_info = {}

signal resource_added(resource_name: String, amount: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


	
func update_player_resource(resource_type: String, rangeX: float, rangeY:float, time: int) -> void: 
	var random_amount = randi_range(rangeX, rangeY)
	#var resource_type = ResourceInventory.ResourceType.SCRAP_WOOD
	resource_info = {
		"random_amount": random_amount,
		"resource": ResourceInventory.get_resource_type(resource_type),
		"resource_name":resource_type
	}
	
	timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	get_tree().root.add_child(timer)  # Add the timer to the root so it persists after menu close
	timer.start()
	print("Timer started for resource gathering.")
	#ResourceInventory.add_resource(ResourceInventory.ResourceType.SCRAP_WOOD, random_amount)
	#print("Added ", random_amount, " ", arr[0].resource, " to inventory")
	
# This function will be called when the timer finishes
func _on_timer_timeout() -> void:
	# Extract the data from the resource info dictionary
	var random_amount = resource_info["random_amount"]
	var resource = resource_info["resource"]
	var resource_name = resource_info["resource_name"]
	print("Timer finished! Adding ", random_amount, " ", resource, " to inventory.")
	
	# Add the resource to the inventory
	ResourceInventory.add_resource(resource, random_amount)
	emit_signal("resource_added", resource_name, random_amount)
	#$Panel/SublocationMenu/TimerLabel.text = "Resource gathered!"d!"

	
