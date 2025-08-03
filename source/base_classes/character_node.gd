@tool
class_name CharacterNode
extends Character

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var texture: Texture2D
#endregion

#region PublicVars
#endregion

#region PrivateVars
var _turn_starting: bool = false
#endregion

#region OnReadyVars
@onready var combat_menu: CombatMenu = $CombatMenu
@onready var animation: AnimationPlayer = $animation
@onready var _health_bar: ProgressBar = $sprite/HealthBar
@onready var _mana_bar: ProgressBar = $sprite/ManaBar
@onready var _blood_particles: CPUParticles2D = $sprite/blood_particles
@onready var _effect_container: ItemList = $sprite/effect_container
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		combat_menu.character = self
		combat_menu.hide()
		$sprite.texture = texture

		_health_bar.max_value = get_stat_total(Global.Stats.MAX_HEALTH)
		_health_bar.value = get_stat_total(Global.Stats.HEALTH)
		_mana_bar.max_value = get_stat_total(Global.Stats.MAX_MANA)
		_mana_bar.value = get_stat_total(Global.Stats.MANA)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if texture != null:
			$sprite.texture = texture
		else:
			$sprite.texture = load("res://assets/sprites/Paladin.png")


#endregion


#region PublicMethods
func take_damage(val: int, ignore_defend: bool = false) -> int:
	var total_damage = super.take_damage(val, ignore_defend)
	_health_bar.value = get_stat_total(Global.Stats.HEALTH)
	self.add_child(DamageNumber.new(total_damage))
	if total_damage > 0:
		_blood_particles.restart()
		_blood_particles.emitting = true
	return total_damage


func handle_turn() -> void:
	animation.play("move_forward")
	_turn_starting = true


func spend_mana(val: int) -> bool:
	var ret_val = super.spend_mana(val)
	_mana_bar.value = get_stat_total(Global.Stats.MANA)
	return ret_val


func add_effect(effect: Effect) -> void:
	super.add_effect(effect)
	_set_icons()


func decay_effects(val: int = 1) -> void:
	super.decay_effects(val)
	_set_icons()


#endregion


#region PrivateMethods
func _set_icons() -> void:
	_effect_container.clear()
	for effect in _effects:
		if effect.eff_icon != null:
			_effect_container.add_icon_item(effect.eff_icon)


#endregion


func _on_combat_menu_turn_end() -> void:
	animation.play_backwards("move_forward")
	turn_end.emit(self)


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_forward" and _turn_starting:
		is_turn = true
		_turn_starting = false
