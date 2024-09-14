extends CanvasLayer


#@onready var game_state: GameState = $"../GameStateManager"
var crafting_panel: Panel
var spawn_buttons 

func _ready() -> void:
	crafting_panel = $CraftingPanel
	spawn_buttons = crafting_panel.get_children()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameStateManager.current_state == GameState.States.SCAVENGING:
		#print("Scavenging")
		crafting_panel.hide()
		for button: Button in spawn_buttons:
			button.disabled = true
	elif (GameStateManager.get_current_cycle() == GameStateManager.DayCycle.NIGHT):
		crafting_panel.hide()
	else:
		crafting_panel.show()
		for button: Button in spawn_buttons:
			button.disabled = false
