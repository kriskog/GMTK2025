extends Node

var transition_time := 0.5

@onready var scene_holder = $SceneHolder
@onready var fader = $FadeLayer/Fader


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.main_menu.connect(_on_main_menu)
	SignalBus.start_game.connect(_on_start_game)
	SignalBus.close_game.connect(_on_close_game)
	SignalBus.victory.connect(_on_victory)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.main_menu.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func transition_to_scene(path: String):
	await fade_out()
	clear_current_scene()

	await get_tree().process_frame

	var scene = load(path)
	if scene == null:
		push_error("Failed to load scene at path: %s" % path)
		return

	var instance = scene.instantiate()
	scene_holder.add_child(instance)

	await fade_in()


func clear_current_scene():
	for child in scene_holder.get_children():
		child.queue_free()


func fade_out() -> void:
	fader.visible = true
	fader.modulate.a = 0.0
	await get_tree().create_timer(0.01).timeout  # Ensure it renders
	await fader_modulate_to(1.0, transition_time)


func fade_in() -> void:
	await fader_modulate_to(0.0, transition_time)
	fader.visible = false


func fader_modulate_to(target_alpha: float, duration: float) -> void:
	var initial_alpha: float = fader.modulate.a
	var elapsed := 0.0

	while elapsed < duration:
		elapsed += get_process_delta_time()
		var time = elapsed / duration
		var alpha = lerp(initial_alpha, target_alpha, time)
		fader.modulate.a = clamp(alpha, 0.0, 1.0)
		await get_tree().process_frame


func close_game() -> void:
	get_tree().quit()


func restart_loop() -> void:
	transition_to_scene(Global.DEATH_SCENE)
	#transition_to_scene(Global.GAME_SCENE) swap to this after the restart works
	#Insert dialogue changing every loop? Hints?


func roll_credits(_loops: int) -> void:
	await Global.Audio_manager.sound_finished
	#you won after loops loops
	#roll credits after - for now, lets return to menu
	transition_to_scene(Global.MAIN_MENU_SCENE)


#handle signals: start_game, exit_game, game_over, victory


func _on_main_menu() -> void:
	transition_to_scene(Global.MAIN_MENU_SCENE)


func _on_start_game() -> void:
	transition_to_scene(Global.GAME_SCENE)


func _on_close_game() -> void:
	close_game()


#Before emitting this signal, await completion of the victory fanfare
#(~10s or await Global.Audio_manager.sound_finished) or require confirmation
#by the user before moving on to rolling credits. Await cannot be used in a signal function.
func _on_victory() -> void:
	roll_credits(Global.current_loop)
	Global.current_loop = 0


func _on_game_over() -> void:
	Global.current_loop += 1
	restart_loop()
