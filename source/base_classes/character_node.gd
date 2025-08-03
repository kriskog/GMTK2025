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
#@onready var _blood_particles: CPUParticles2D = $blood_particles
@onready var _health_bar: ProgressBar = $HealthBar
@onready var _mana_bar: ProgressBar = $ManaBar
@onready var animation: AnimationPlayer = $animation
@onready var _blood_particles: CPUParticles2D = $sprite/blood_particles
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_menu.character = self
	_health_bar.max_value = get_stat_total(Global.Stats.MAX_HEALTH)
	_health_bar.value = get_stat_total(Global.Stats.HEALTH)
	_mana_bar.max_value = get_stat_total(Global.Stats.MAX_MANA)
	_mana_bar.value = get_stat_total(Global.Stats.MANA)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_mana_bar.value = get_stat_total(Global.Stats.MANA)
	if not Engine.is_editor_hint():
		combat_menu.character = self
		combat_menu.hide()
		$sprite.texture = texture


#endregion


#region PublicMethods
func take_damage(val: int, ignore_defend: bool = false) -> int:
	var total_damage = super.take_damage(val, ignore_defend)
	self.add_child(DamageNumber.new(total_damage))
	if total_damage > 0:
		_blood_particles.restart()
		_blood_particles.emitting = true
	return total_damage


func handle_turn() -> void:
	animation.play("move_forward")
	_turn_starting = true


#endregion

#region PrivateMethods

#endregion


func _on_combat_menu_turn_end() -> void:
	animation.play_backwards("move_forward")
	turn_end.emit(self)


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_forward" and _turn_starting:
		is_turn = true
		_turn_starting = false
