class_name EffectBase
extends Resource
"""Effects are buffs/debuffs which modify stats and/or deal damage over time.
This is the base attributes of an effect, which needs to be instantiated and
applied to a character.
"""

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var _stat_changes: Dictionary = {
	Global.Stats.HEALTH: 0,
	Global.Stats.MAX_HEALTH: 0,
	Global.Stats.MANA: 0,
	Global.Stats.MAX_MANA: 0,
	Global.Stats.STRENGTH: 0,
	Global.Stats.DEXTERITY: 0,
	Global.Stats.SPEED: 0,
	Global.Stats.MAGIC: 0,
}
@export var max_duration: int = 1
@export var damage_over_time: bool = false
@export var damage: int = 0
@export var damage_attribute: Global.Stats
@export var status: Global.Status

#endregion

#region PublicVars
#endregion

#region PrivateVars
#endregion

#region OnReadyVars
#endregion

#region BuiltinMethods
#endregion


#region PublicMethods
func get_stat_bonus(stat: Global.Stats) -> int:
	return _stat_changes[stat]


func add_damage(val: int) -> void:
	damage += val


func deal_damage() -> int:
	return damage

#endregion

#region PrivateMethods
#endregion
