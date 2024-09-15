extends Button

@export var object_to_spawn: PackedScene
#@export var resource_cost: Dictionary
@export var barricade_level: String
#@onready var game_state_manager = $"../../GameStateManager"
var obj

var barricade_costs = {
	"level_1": {ResourceInventory.ResourceType.WOOD: 3, ResourceInventory.ResourceType.NAILS: 4},
	"level_2": {ResourceInventory.ResourceType.WOOD: 8, ResourceInventory.ResourceType.NAILS: 6, ResourceInventory.ResourceType.METAL: 1},
	"level_3": {ResourceInventory.ResourceType.WOOD: 15, ResourceInventory.ResourceType.NAILS: 15, ResourceInventory.ResourceType.METAL: 4}
}

func _ready() -> void:
	if object_to_spawn == null:
		disabled = true
	else:
		obj = load(object_to_spawn.resource_path)
		#icon = obj
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if button_pressed && object_to_spawn != null:
		#var cost = barricade_costs.get(barricade_level)
		#if has_resource(cost):
			#var instance: Node2D = obj.instantiate()
			#get_node("/root").add_child(instance)
			## Hacky. to prevent obj spawning at 0,0 for one frame. No time to fix
			#instance.position = Vector2(-9999,-9999)
			#print("instantiating")
			#deduct_resources(cost)
			##game_state_manager.enter_building_state()
		#else: 
			#print("Not enough resources!")
			pass

func has_resource(cost: Dictionary) -> bool:
	for resource_type in cost.keys():
		if ResourceInventory.get_resource_amount(resource_type) < cost[resource_type]:
			return false
	return true
	
func deduct_resources(cost: Dictionary) -> void:
	for resource_type in cost.keys():
		ResourceInventory.remove_resource(resource_type, cost[resource_type])
		
		


func _on_pressed():
	if object_to_spawn != null:
		var cost = barricade_costs.get(barricade_level)
		if has_resource(cost):
			var mouse_pos = get_viewport().get_mouse_position()
			var instance: Node2D = obj.instantiate()
			#get_node("/root").add_child(instance)
			get_tree().root.add_child(instance)
			# Hacky. to prevent obj spawning at 0,0 for one frame. No time to fix
			#instance.position = Vector2(-9999,-9999)
			instance.position = mouse_pos
			print("instantiating")
			deduct_resources(cost)
			#game_state_manager.enter_building_state()
		else: 
			print("Not enough resources!")
