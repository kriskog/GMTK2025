class_name CharacterNode
extends Character

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var sprite: Texture2D
#endregion

#region PublicVars
#endregion

#region PrivateVars
var _blood_particles: CPUParticles2D
var _character_sprite: Sprite2D
#endregion

#region OnReadyVars
@onready var damage_numbers_origin = $"/root/DamageNumber"
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_blood_particles = $blood_particles
	_character_sprite = $character_sprite
	if sprite != null:
		_character_sprite.texture = sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#endregion


#region PublicMethods
func take_damage(val: int) -> void:
	super.take_damage(val)
	DamageNumber.display_number(val, _character_sprite.global_position)
	_blood_particles.restart()
	_blood_particles.emitting = true
#endregion

#region PrivateMethods
#endregion
