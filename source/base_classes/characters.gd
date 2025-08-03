class_name Character
extends Node2D

#region Signals
@warning_ignore("unused_signal")
signal turn_end(character: Character)
#endregion

#region Enums
#endregion

#region Constants
const BASIC_ATTACK_INDEX = -1
#endregion

#region ExportVars
@export var basic_attack: Ability = preload("res://source/abilities/basic_attack.tres")
@export var abilities: Array[Ability]
## Stats should only be accessed via the get/set functionality, since those
## calculate the effect bonuses properly.
@export var _stats = {
	Global.Stats.MAX_HEALTH: 0,
	Global.Stats.HEALTH: 0,
	Global.Stats.MAX_MANA: 0,
	Global.Stats.MANA: 0,
	Global.Stats.STRENGTH: 0,
	Global.Stats.DEXTERITY: 0,
	Global.Stats.SPEED: 0,
	Global.Stats.MAGIC: 0,
}
@export var character_name: String
#endregion

#region PublicVars
var is_turn: bool = false:
	get:
		return is_turn
	set(value):
		is_turn = value

var is_hasted: bool = false:
	get:
		return is_hasted
	set(value):
		is_hasted = value

var defending: bool = false:
	get:
		return defending
	set(value):
		defending = value
#endregion

#region PrivateVars
var _effects: Array[Effect]
#endregion

#region OnReadyVars
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#endregion


#region PublicMethods
func update_state(stat: Global.Stats, value: int) -> void:
	_stats[stat] += value


func get_stat_total(stat: Global.Stats) -> int:
	return _stats[stat] + get_effect_bonuses(stat)


func get_effect_bonuses(stat: Global.Stats) -> int:
	var total: int = 0
	for effect in _effects:
		total += effect.get_stat_bonus(stat)
	return total


func get_ability_damage(ability: Ability) -> int:
	return ability.get_total_damage(get_stat_total(ability.damage_attribute))


func take_damage(val: int, ignore_defend: bool = false) -> int:
	# Take an amount of damage to health
	var damage_taken: int = val
	if !ignore_defend and defending:
		@warning_ignore("integer_division")
		damage_taken = val / 2

	damage_taken = clamp(damage_taken, -Global.MAX_DAMAGE, Global.MAX_DAMAGE)
	update_state(Global.Stats.HEALTH, -damage_taken)
	return damage_taken


func spend_mana(val: int) -> bool:
	# This succeeds if there's enough mana to pay the cost, and only spends the mana if so
	if val <= get_stat_total(Global.Stats.MANA):
		update_state(Global.Stats.MANA, -val)
		return true
	return false


func use_ability_on_target(ability_num: int, all_targets: Array, target_num: int) -> void:
	var used_ability: Ability
	# override for basic "attack" action
	if ability_num == BASIC_ATTACK_INDEX:
		used_ability = basic_attack
	else:
		used_ability = abilities[ability_num]

	if spend_mana(used_ability.mana_cost):
		if used_ability.target_number == Global.TargetNumber.ALL:
			for target in all_targets:
				_use_ability_on_target(used_ability, target)
		if used_ability.target_number == Global.TargetNumber.SELF:
			_use_ability_on_target(used_ability, self)
		else:
			_use_ability_on_target(used_ability, all_targets[target_num])


func add_effect(effect: Effect) -> void:
	_effects.append(effect)


func decay_effects(val: int = 1) -> void:
	# Reduce all effects' duration by 1 turn, keep all effects that still have duration
	var still_active: Array[Effect] = []
	for effect in _effects:
		effect.reduce_duration(val)

		if effect.damage_over_time:
			take_damage(effect.deal_damage())

		if not effect.decayed():
			still_active.append(effect)

	_effects = still_active


func handle_turn() -> void:
	pass


#endregion


#region PrivateMethods
## This applies the ability effect and damage to a single target
func _use_ability_on_target(used_ability: Ability, target: Character) -> void:
	# can't target deaddies
	if target.get_stat_total(Global.Stats.HEALTH) <= 0:
		return

	if used_ability.deals_damage:
		var attack_damage: int = get_ability_damage(used_ability)
		# friendly moves heal
		if used_ability.target == Global.Target.ALLY:
			attack_damage *= -1
		target.take_damage(attack_damage)

	if used_ability.effect_base != null:
		var effect: Effect = Effect.new(used_ability.effect_base)

		if effect.damage_over_time and effect.damage_attribute != null:
			var damage_over_time = get_stat_total(effect.damage_attribute)
			if used_ability.target == Global.Target.ALLY:
				damage_over_time *= -1
			effect.add_damage(damage_over_time)

		target.add_effect(effect)
#endregion
