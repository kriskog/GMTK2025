extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect signals to buttons
	%StartGameButton.pressed.connect(_on_start_game_pressed)
	%HowToPlayButton.pressed.connect(_on_how_to_play_pressed)
	%CreditsButton.pressed.connect(_on_credits_pressed)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)


#region Signal funcs


# Makes sure we do the important things when the menu opens. Set button focus, menu music?
func _on_tree_entered() -> void:
	%StartGameButton.grab_focus()


func _on_tree_exited() -> void:
	pass


func _on_start_game_pressed() -> void:
	SignalBus.button_clicked.emit()
	SignalBus.start_game.emit()
	#get_tree().change_scene_to_file("res://source/scenes/game/game.tscn")


func _on_how_to_play_pressed() -> void:
	SignalBus.button_clicked.emit()
	%HowToPlay.show()


func _on_credits_pressed() -> void:
	SignalBus.button_clicked.emit()
	%CreditsOverlay.show()


func _on_exit_game_pressed() -> void:
	SignalBus.button_clicked.emit()
	SignalBus.close_game.emit()

#endregion
