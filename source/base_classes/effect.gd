class_name Effect
extends EffectBase
"""This is an active instance of an effect, which has a duration."""

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
#endregion

#region PublicVars
var cur_duration: int
#endregion

#region PrivateVars
#endregion

#region OnReadyVars
#endregion


#region BuiltinMethods
func _init(effect_base: EffectBase) -> void:
	self._stat_changes = effect_base._stat_changes
	self.max_duration = effect_base.max_duration
	self.damage_over_time = effect_base.damage_over_time
	self.damage = effect_base.damage
	self.damage_attribute = effect_base.damage_attribute
	self.status = effect_base.status
	self.eff_icon = effect_base.eff_icon

	cur_duration = max_duration


#endregion


#region PublicMethods
func reduce_duration(val: int = 1) -> void:
	cur_duration -= val


func decayed() -> bool:
	return cur_duration <= 0
#endregion

#region PrivateMethods
#endregion
