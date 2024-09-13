extends Node2D

var notification_timer: Timer = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LocationStateManager.connect("resource_added", Callable(self, "_on_resource_added"))
	
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
