class_name Character
extends Node2D

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var stats = {
	Global.stats.HEALTH: 0,
	Global.stats.MAX_HEALTH: 0,
	Global.stats.MANA: 0,
	Global.stats.MAX_MANA: 0,
	Global.stats.STRENGTH: 0,
	Global.stats.DEXTERITY: 0,
	Global.stats.SPEED: 0,
	Global.stats.MAGIC: 0,
}
@export var abilities: Array[Ability]
#endregion

#region PublicVars
#endregion

#region PrivateVars
var is_turn: bool = false:
	get:
		return is_turn
	set(value):
		is_turn = value
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
func update_state(stat: Global.stats, value: int) -> void:
	stats[stat] += value


func get_ability_damage(ability: Ability) -> int:
	return ability.get_total_damage(stats[ability.damage_attribute])


func take_damage(val: int) -> void:
	# Take an amount of damage to health
	update_state(Global.stats.HEALTH, -val)


func spend_mana(val: int) -> bool:
	# This succeeds if there's enough mana to pay the cost, and only spends the mana if so
	if val <= stats[Global.stats.MANA]:
		update_state(Global.stats.MANA, -val)
		return true
	return false
	
	
func use_ability_on_target(num: int, target: Character) -> void:
	var attack_ability: Ability = abilities[num]
	if spend_mana(attack_ability.mana_cost):
		var attack_damage: int = get_ability_damage(attack_ability)
		target.take_damage(attack_damage)
#endregion

#region PrivateMethods
#endregion
