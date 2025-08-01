class_name Ability
extends Resource

#region Signals
#endregion

#region Enums
enum Target { ALLY, ENEMY }
#endregion

#region Constants
#endregion

#region ExportVars
@export var name: String = ""
@export var mana_cost: int = 0
@export var target: Target = Target.ENEMY
@export var base_damage: int = 0
@export var damage_attribute: Global.stats = Global.stats.STRENGTH
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
