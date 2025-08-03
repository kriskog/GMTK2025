class_name Ability
extends Resource

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var name: String = ""
@export var mana_cost: int = 0
@export var target: Global.Target = Global.Target.ENEMY
@export var deals_damage: bool = true
@export var base_damage: int = 0
@export var damage_attribute: Global.Stats = Global.Stats.STRENGTH
@export var effect_base: EffectBase = null
@export var target_number: Global.TargetNumber = Global.TargetNumber.ONE
@export var restore_mana: bool = false
@export var mana_restored: int = 0
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
func get_total_damage(bonus: int) -> int:
	## The "bonus" here should be the character's relevant stat amount
	return base_damage + bonus
#endregion

#region PrivateMethods
#endregion
