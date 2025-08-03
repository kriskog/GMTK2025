extends Control

@onready var scroll = $ScrollContainer
@onready var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().create_timer(0.5).timeout
	start_credits_roll()

func start_credits_roll():
	var scroll_range = scroll.get_v_scroll_bar().max_value
	tween.tween_property(scroll.get_v_scroll_bar(), "value", scroll_range, 20.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	SignalBus.button_clicked.emit()
	SignalBus.main_menu.emit()
	
