extends Node

enum ResourceType { SCRAP_WOOD, WOOD, SCRAP_METAL, METAL, NAILS, ROPE, BRICKS, FUEL, PLAYER, VILLAGERS}

enum WinningResource {SPARK_PLUG, PULL_STRING, PROPELLER }

signal resource_changed(resource_type: ResourceType)

func get_resource_name(resource_type):
	match resource_type:
		ResourceType.SCRAP_WOOD:
			return "Scrap Wood"
		ResourceType.WOOD:
			return "Wood"
		ResourceType.SCRAP_METAL:
			return "Scrap Metal"
		ResourceType.METAL: 
			return "Metal"
		ResourceType.NAILS:
			return "Nails"
		ResourceType.ROPE:
			return "Rope"
		ResourceType.BRICKS:
			return "Bricks"
		ResourceType.FUEL:
			return "Fuel"
		ResourceType.PLAYER:
			return "Player"
		ResourceType.VILLAGERS:
			return "Villagers"
	
func get_resource_type(resource_name):
	match resource_name:
		"Wood":
			return ResourceType.WOOD
		"Metal":
			return ResourceType.METAL
		"Nails":
			return ResourceType.NAILS
		"Fuel": 
			return ResourceType.FUEL

func get_winning_resource_name(winning_type):
	match winning_type:
		WinningResource.SPARK_PLUG:
			return "Spark Plug"
		WinningResource.PULL_STRING:
			return "Pull String"
		WinningResource.PROPELLER:
			return "Propeller"


var resources = {
	ResourceType.SCRAP_WOOD: 0,
	ResourceType.WOOD: 0,
	ResourceType.SCRAP_METAL: 0,
	ResourceType.METAL: 0,
	ResourceType.NAILS: 0,
	ResourceType.ROPE: 0,
	ResourceType.BRICKS: 0,
	ResourceType.FUEL: 40,
	ResourceType.PLAYER: 1,
	ResourceType.VILLAGERS: 3,
}

var winning_resources = {
	WinningResource.SPARK_PLUG: 0,
	WinningResource.PULL_STRING: 0,
	WinningResource.PROPELLER: 0,
}

func add_resource(resource_type, amount):
	if resources.has(resource_type):
		resources[resource_type] += amount
		print("updated amount", resource_type)
		emit_signal("resource_changed", resource_type)
		
func remove_resource(resource_type, amount):
	if resources.has(resource_type) and resources[resource_type] >= amount:
		resources[resource_type] -= amount
		if resources[resource_type] < 0:
			resources[resource_type] = 0
		emit_signal("resource_changed", resource_type)
		
func get_resource_amount(resource_type):
	return resources.get(resource_type, 0)
	
func add_winning_resource(resource_type):
	if winning_resources.has(resource_type) and not winning_resources[resource_type] > 1:
		winning_resources[resource_type] += 1
