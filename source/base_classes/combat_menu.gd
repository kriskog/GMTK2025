extends Control

#region Signals
#endregion

#region Enums
#endregion

#region Constants
#endregion

#region ExportVars
@export var character: CharacterNode
@export var allies: Array[CharacterNode]
@export var enemies: Array[CharacterNode]
#endregion

#region PublicVars
#endregion

#region PrivateVars
var _chosen_ability: int
var _basic_attack: bool = false
#endregion

#region OnReadyVars
@onready var ability_list = $ActionList/Abilities
@onready var enemy_list = $EnemyList
@onready var ally_list = $AllyList
#endregion


#region BuiltinMethods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ability in character.abilities:
		ability_list.get_popup().add_item(ability["name"].capitalize())
	ability_list.get_popup().id_pressed.connect(_ability_pressed)

	for ally in allies:
		ally_list.add_item(ally["character_name"].capitalize())

	for enemy in enemies:
		enemy_list.add_item(enemy["character_name"].capitalize())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (character.is_turn):
		show()
	else:
		hide()


#endregion


#region PublicMethods
#endregion

#region PrivateMethods
func _ability_pressed(id: int) -> void:
	_chosen_ability = id
	var mana_cost = character.abilities[id].mana_cost
	var target = character.abilities[id].target
	if (!character.spend_mana(mana_cost)):
		print("Not enough mana!!!")
		_chosen_ability = -1
	else:
		if (target == Global.Target.ENEMY):
			enemy_list.visible = true
		else:
			ally_list.visible = true

func _on_attack_pressed() -> void:
	_basic_attack = true
	enemy_list.visible = true

func _on_ally_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	if (_basic_attack):
		character.basic_attack(allies[index])
	else:
		character.use_ability_on_target(_chosen_ability, allies[index])
	ally_list.visible = false

func _on_enemy_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	if (_basic_attack):
		character.basic_attack(enemies[index])
	else:
		character.use_ability_on_target(_chosen_ability, enemies[index])
	enemy_list.visible = false
#endregion
