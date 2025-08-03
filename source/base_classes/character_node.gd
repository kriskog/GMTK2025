class_name CharacterNode
extends Character

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
#endregion

#region OnReadyVars
@onready var damage_numbers_origin = $"/root/DamageNumber"
@onready var combat_menu: CombatMenu = $CombatMenu
@onready var _blood_particles: CPUParticles2D = $blood_particles
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_menu.character = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#endregion


#region PublicMethods
func take_damage(val: int) -> void:
	super.take_damage(val)
	DamageNumber.display_number(val, self.global_position)
	_blood_particles.restart()
	_blood_particles.emitting = true


#endregion

#region PrivateMethods

#endregion


func _on_combat_menu_turn_end() -> void:
	turn_end.emit(self)
