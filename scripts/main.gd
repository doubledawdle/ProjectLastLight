extends Node2D

var notification_timer: Timer = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LocationStateManager.connect("resource_added", Callable(self, "_on_resource_added"))
	GameStateManager.connect("update_timer", Callable(self, "_on_update_timer"))
	GameStateManager.connect("change_background", Callable(self, "_on_background_change"))
	
	# Create a Timer node for handling when the text disappears
	notification_timer = Timer.new()
	notification_timer.wait_time = 3  # Time in seconds before the text disappears
	notification_timer.one_shot = true
	notification_timer.connect("timeout", Callable(self, "_hide_notification"))
	add_child(notification_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_resource_added(resource_name: String, amount: int) -> void:
	$NotificationLabel.text = "Added " + str(amount) + " " + resource_name + " to inventory!"
	$NotificationLabel.visible = true
	
	# Start the timer to hide the notification after a few seconds
	notification_timer.start()
	
func _hide_notification() -> void:
	$NotificationLabel.visible = false
	
func _on_update_timer(time_left: float) -> void:
	var curr_cycle = GameStateManager.get_current_cycle()
	var timer_label = $Timer  
	if time_left > 0:
		var minutes = int(time_left) / 60
		var seconds = int(time_left) % 60
		timer_label.text = GameStateManager.get_cycle_name(curr_cycle) + ": " + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	else:
		timer_label.text = "Time's up!"
		
func _on_background_change(curr_cycle: GameStateManager.DayCycle) -> void:
	if (curr_cycle == GameStateManager.DayCycle.EVENING):
		$Foreground.texture = load("res://Objects/foreground- Evening.png")
	elif (curr_cycle == GameStateManager.DayCycle.NIGHT):
		$Foreground.texture = load("res://Objects/foreground-Night.png")
	else:
		$Foreground.texture = load("res://Objects/foreground (1).png")
