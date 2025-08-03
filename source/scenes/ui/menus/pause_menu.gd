extends Control

signal unpaused


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signals to buttons
	%ContinueButton.pressed.connect(_on_continue_pressed)
	%MainMenuButton.pressed.connect(_on_main_menu_pressed)
	visibility_changed.connect(_on_visibility_changed)
	hide()  # Keybind will unhide, and focus buttons


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_pause"):
		if visible:
			hide()
		else:
			show()


#region Signal funcs


func _on_continue_pressed() -> void:
	SignalBus.button_clicked.emit()
	hide()


func _on_main_menu_pressed() -> void:
	SignalBus.button_clicked.emit()
	hide()
	SignalBus.main_menu.emit()


func _on_visibility_changed() -> void:
	if visible:
		get_tree().paused = true
		%ContinueButton.grab_focus()
	else:
		get_tree().paused = false
		unpaused.emit()

#endregion
