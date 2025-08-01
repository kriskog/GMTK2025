extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func on_button_pressed() -> void:
	get_node("../../CanvasLayer/PauseMenu").show()
