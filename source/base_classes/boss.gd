class_name BossNode
extends Character

#region Signals
signal dead
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
#endregion

#region PublicVars
var targets: Array[CharacterNode]
#endregion

#region PrivateVars
var _current_turn: int = 0
var _attacking: bool = false
#endregion

#region OnReadyVars
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var _blood_particles: CPUParticles2D = $sprite/blood_particles
@onready var _effect_container: ItemList = $sprite/effect_container
#endregion


#region BuiltinMethods
func _ready():
	_effect_container.scale = Vector2(1, 1) / $sprite.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_stat_total(Global.Stats.HEALTH) <= 0:
		dead.emit()


#endregion


#region PublicMethods
func handle_turn() -> void:
	_attacking = true
	animation.play("move")


func take_damage(val: int, ignore_defend: bool = false) -> int:
	var total_damage: int = super.take_damage(val, ignore_defend)
	self.add_child(DamageNumber.new(total_damage))
	if total_damage > 0:
		_blood_particles.restart()
		_blood_particles.emitting = true
	return total_damage


func add_effect(effect: Effect) -> void:
	super.add_effect(effect)
	_set_icons()


func decay_effects(val: int = 1) -> void:
	super.decay_effects(val)
	_set_icons()


#endregion


#region PrivateMethods
func _sort_targets(a: Character, b: Character):
	return a.get_stat_total(Global.Stats.HEALTH) < b.get_stat_total(Global.Stats.HEALTH)


func _first_turn() -> void:
	targets.sort_custom(_sort_targets)
	var target = 0
	for new_target in targets.size():
		if targets[new_target].statuses.has(Global.Status.PROVOKE):
			target = new_target
	SignalBus.attack5.emit()
	use_ability_on_target(0, targets, target)


func _second_turn() -> void:
	SignalBus.attack5.emit()
	use_ability_on_target(1, targets, -1)


func _third_turn() -> void:
	targets.sort_custom(_sort_targets)
	var target = 0
	for new_target in targets.size():
		if targets[new_target].statuses.has(Global.Status.PROVOKE):
			target = new_target
	SignalBus.attack5.emit()
	use_ability_on_target(2, targets, target)


func _fourth_turn() -> void:
	SignalBus.attack5.emit()
	use_ability_on_target(3, targets, -1)


func _final_turn() -> void:
	SignalBus.attack5.emit()
	use_ability_on_target(4, targets, -1)


func _set_icons() -> void:
	_effect_container.clear()
	for effect in _effects:
		if effect.eff_icon != null:
			_effect_container.add_icon_item(effect.eff_icon)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _attacking:
		_current_turn += 1
		match _current_turn:
			1:
				_first_turn()
			2:
				_second_turn()
			3:
				_third_turn()
			4:
				_fourth_turn()
			5:
				_final_turn()
		turn_end.emit(self)
		_attacking = false
		animation.play_backwards("move")

#endregion
