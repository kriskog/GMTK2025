extends CharacterNode

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var _targets: Array[Character]
#endregion

#region PublicVars
#endregion

#region PrivateVars
var _current_turn: int = 0
#endregion

#region OnReadyVars
#endregion


#region BuiltinMethods
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#endregion


#region PublicMethods
#endregion

#region PrivateMethods
func _handle_turn() -> void:
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
	if _current_turn < 5: _handle_turn()

func _sort_targets(a: Character, b: Character):
	if a.get_stat_total(Global.Stats.HEALTH) < b.get_stat_total(Global.Stats.HEALTH):
		return true
	return false

func _first_turn() -> void:
	_targets.sort_custom(_sort_targets)
	var target = _targets[0]
	use_ability_on_target(0, target)

func _second_turn() -> void:
	for target in _targets:
		use_ability_on_target(1, target)

func _third_turn() -> void:
	_targets.sort_custom(_sort_targets)
	var target = _targets[0]
	use_ability_on_target(2, target)

func _fourth_turn() -> void:
	for target in _targets:
		use_ability_on_target(3, target)

func _final_turn() -> void:
	for target in _targets:
		use_ability_on_target(4, target)
	
#endregion


func _on_timer_timeout() -> void:
	_handle_turn()
