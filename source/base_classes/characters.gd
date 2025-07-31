class_name Character
extends Node

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
#endregion

#region PublicVars
#endregion

#region PrivateVars
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
#endregion

#region PrivateMethods
#endregion
