extends Node


enum ResourceType { SCRAP_WOOD, WOOD, SCRAP_METAL, METAL, NAILS, ROPE, BRICKS, FUEL}

enum WinningResource {SPARK_PLUG, PULL_STRING, }

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
