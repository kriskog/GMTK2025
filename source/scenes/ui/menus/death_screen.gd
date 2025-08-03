extends Control

var hints = [
	"The boss does massive damage, try finding ways to reduce it.",
	"Is there a pattern to the attacks?",
	"Do you know what all of your abilities do?",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.current_loop >= 4:
		$VBoxContainer/HintText.text = hints.pick_random()


func _on_retry_pressed() -> void:
	SignalBus.start_game.emit()


func _on_give_up_pressed() -> void:
	SignalBus.main_menu.emit()
