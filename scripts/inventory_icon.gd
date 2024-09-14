extends Sprite2D

@export var resource_type : ResourceInventory.ResourceType


# Called when the node enters the scene tree for the first time.
func _ready():
	var resource_inventory = get_node("/root/ResourceInventory")
	resource_inventory.connect("resource_changed", Callable(self, "_on_resource_changed"))
	_update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _update_label() -> void:
	var resource_name = ResourceInventory.get_resource_name(resource_type)
	$Label.text = resource_name + " " + str(ResourceInventory.get_resource_amount(resource_type))
	
func _on_resource_changed(resource: ResourceInventory.ResourceType) -> void:
	
	if resource == self.resource_type:
		_update_label()
