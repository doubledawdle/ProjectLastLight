extends CanvasLayer

var arr : Array = []
var timer: Timer = null # ref for the timer 
var resource_info = {}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup(sublocationsArr: Array):
	arr = sublocationsArr
	$Panel/sublocation1/Title.text = sublocationsArr[0].title
	$Panel/sublocation1/ResourceRange.text = str(sublocationsArr[0].range.x) + " - " + str(sublocationsArr[0].range.y) + " " + sublocationsArr[0].resource
	
	$Panel/sublocation2/Title.text = sublocationsArr[1].title
	$Panel/sublocation2/ResourceRange.text = str(sublocationsArr[1].range.x) + " - " + str(sublocationsArr[1].range.y) + " " + sublocationsArr[1].resource
	
	$Panel/sublocation3/Title.text = sublocationsArr[2].title
	$Panel/sublocation3/ResourceRange.text = str(sublocationsArr[2].range.x) + " - " + str(sublocationsArr[2].range.y) + " " + sublocationsArr[2].resource


func _on_close_pressed():
	queue_free()


func _on_sublocation_1_pressed():
	# need to add a resource to inventory for player and villagers. Will check if 
	# player and villager is = to 0 before running the logic.
	# in the timeout function set the player back to 1 and add one back to the villagers 
	print("I've Been Pressed!")
	var random_amount = randi_range(arr[0].range.x, arr[0].range.y)
	var resource_type = ResourceInventory.ResourceType.SCRAP_WOOD
	resource_info = {
		"random_amount": random_amount,
		"resource": resource_type
	}
	
	timer = Timer.new()
	timer.wait_time = arr[0].time
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
	print("Timer finished! Adding ", random_amount, " ", resource, " to inventory.")
	
	# Add the resource to the inventory
	ResourceInventory.add_resource(ResourceInventory.ResourceType.SCRAP_WOOD, random_amount)
	#$Panel/SublocationMenu/TimerLabel.text = "Resource gathered!"d!"
