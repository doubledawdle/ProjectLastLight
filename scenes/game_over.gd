extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Days.text = "You Survived For " + str(GameStateManager.get_days_survived()) + " days"
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	print("I've been pressed")
	GameStateManager.days_survived = 0
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
