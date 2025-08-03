extends Node

#Global signal emitter, autoloaded. Emit signals here if working across scenes,
#without instantiating the scene as a child.
#region Signals
@warning_ignore("unused_signal")
signal main_menu
@warning_ignore("unused_signal")
signal button_clicked
@warning_ignore("unused_signal")
signal start_game
@warning_ignore("unused_signal")
signal close_game
@warning_ignore("unused_signal")
signal victory
@warning_ignore("unused_signal")
signal game_over
@warning_ignore("unused_signal")
signal credits
@warning_ignore("unused_signal")
signal attack1
@warning_ignore("unused_signal")
signal attack2
@warning_ignore("unused_signal")
signal attack3
@warning_ignore("unused_signal")
signal attack4
@warning_ignore("unused_signal")
signal attack5
@warning_ignore("unused_signal")
signal buff
@warning_ignore("unused_signal")
signal debuff
#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
