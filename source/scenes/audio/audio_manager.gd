extends Node

@onready var click: AudioStreamPlayer = $click
@onready var title_theme: AudioStreamPlayer = $title_theme
@onready var credits_theme: AudioStreamPlayer = $credits_theme
@onready var boss_theme: AudioStreamPlayer = $boss_theme
@onready var victory_fanfare: AudioStreamPlayer = $victory_fanfare
@onready var loss_dirge: AudioStreamPlayer = $loss_dirge
@onready var attack1: AudioStreamPlayer = $attack1
@onready var attack2: AudioStreamPlayer = $attack2
@onready var attack3: AudioStreamPlayer = $attack3
@onready var attack4: AudioStreamPlayer = $attack4
@onready var attack5: AudioStreamPlayer = $attack5
@onready var buff: AudioStreamPlayer = $buff
@onready var debuff: AudioStreamPlayer = $debuff


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.main_menu.connect(_on_main_menu)
	SignalBus.button_clicked.connect(_on_button_clicked)
	SignalBus.start_game.connect(_on_start_game)
	SignalBus.close_game.connect(_on_close_game)
	SignalBus.victory.connect(_on_victory)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.credits.connect(_on_credits)
	SignalBus.attack1.connect(_on_attack1)
	SignalBus.attack2.connect(_on_attack2)
	SignalBus.attack3.connect(_on_attack3)
	SignalBus.attack4.connect(_on_attack4)
	SignalBus.attack5.connect(_on_attack5)
	SignalBus.buff.connect(_on_buff)
	SignalBus.debuff.connect(_on_debuff)
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func stop_all_sounds():
	for child in get_children():
		if child is AudioStreamPlayer and child.playing:
			child.stop()


func _on_button_clicked() -> void:
	click.play()


func _on_main_menu() -> void:
	stop_all_sounds()
	title_theme.play()


func _on_start_game() -> void:
	stop_all_sounds()
	boss_theme.play()


func _on_close_game() -> void:
	stop_all_sounds()


func _on_victory() -> void:
	stop_all_sounds()
	victory_fanfare.play()
	await victory_fanfare.finished


func _on_game_over() -> void:
	stop_all_sounds()
	loss_dirge.play()
	await loss_dirge.finished


func _on_credits() -> void:
	stop_all_sounds()
	credits_theme.play()

func _on_attack1() -> void:
	attack1.play()

func _on_attack2() -> void:
	attack2.play()

func _on_attack3() -> void:
	attack3.play()

func _on_attack4() -> void:
	attack4.play()

func _on_attack5() -> void:
	attack5.play()

func _on_buff() -> void:
	buff.play()
	
func _on_debuff() -> void:
	debuff.play()
