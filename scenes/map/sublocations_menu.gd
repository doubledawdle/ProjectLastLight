extends CanvasLayer

var arr : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup(sublocationsArr: Array):
	arr = sublocationsArr
	$Panel/SublocationMenu/sublocation1/Title.text = sublocationsArr[0].title
	$Panel/SublocationMenu/sublocation1/ResourceRange.text = str(sublocationsArr[0].range.x) + " - " + str(sublocationsArr[0].range.y) + " " + sublocationsArr[0].resource
	
	$Panel/SublocationMenu/sublocation2/Title.text = sublocationsArr[1].title
	$Panel/SublocationMenu/sublocation2/ResourceRange.text = str(sublocationsArr[1].range.x) + " - " + str(sublocationsArr[1].range.y) + " " + sublocationsArr[1].resource
	
	$Panel/SublocationMenu/sublocation3/Title.text = sublocationsArr[2].title
	$Panel/SublocationMenu/sublocation3/ResourceRange.text = str(sublocationsArr[2].range.x) + " - " + str(sublocationsArr[2].range.y) + " " + sublocationsArr[2].resource


func _on_close_pressed():
	queue_free()


func _on_sublocation_1_pressed():
	print("I've Been Pressed!")
	var random_amount = randi_range(arr[0].range.x, arr[0].range.y)
	ResourceInventory.add_resource(ResourceInventory.ResourceType.SCRAP_WOOD, random_amount)
	print("Added ", random_amount, " ", arr[0].resource, " to inventory")
