extends Sprite2D

# Variables to set for sublocation menu
@export var sublocation1_title: String
@export var sublocation2_title: String
@export var sublocation3_title: String
@export var sublocation1_resource: ResourceInventory.ResourceType
@export var sublocation2_resource: ResourceInventory.ResourceType
@export var sublocation3_resource: ResourceInventory.ResourceType
@export var sublocation1_range: Vector2
@export var sublocation2_range: Vector2
@export var sublocation3_range: Vector2
@export var sublocation1_time: int
@export var sublocation2_time: int
@export var sublocation3_time: int

var sublocationsArr : Array 



var target_scale : Vector2 = Vector2(1.4, 1.4)
var default_scale : Vector2
var duration : float = 0.5
var bounce_distance : float = 20.0 # Distance to bounce left and right
var tween : Tween



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sublocationsArr = [
		{"title": sublocation1_title, "resource": ResourceInventory.get_resource_name(sublocation1_resource), "range": sublocation1_range, "time": sublocation1_time},
		{"title": sublocation2_title, "resource": ResourceInventory.get_resource_name(sublocation2_resource), "range": sublocation2_range, "time": sublocation2_time},
		{"title": sublocation3_title, "resource": ResourceInventory.get_resource_name(sublocation3_resource), "range": sublocation3_range, "time": sublocation3_time}
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	tween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", target_scale, duration).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(self, "rotation", -0.2, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", 0.2, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(duration / 2)
	tween.set_loops()
	
	
	


func _on_area_2d_mouse_exited() -> void:
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), duration)
	tween.tween_property(self, "rotation", 0, 0.3)
	
	
	


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("select"):
			var sublocation_menu_scene = preload("res://scenes/map/sublocations_menu.tscn")
			var sublocation_menu = sublocation_menu_scene.instantiate()
			sublocation_menu.setup(sublocationsArr)
			add_child(sublocation_menu)
			
