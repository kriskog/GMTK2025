extends Node

var turncount: int = 0
var charlist: Array[Node] = []
var dead_characters: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_charlist()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func fill_charlist() -> void:
	var allies: Array[CharacterNode] = _get_character_node_children($PlayableCharacters)
	var enemies: Array[BossNode] = _get_boss_node_children($EnemyCharacters)
	charlist.append_array(allies)
	charlist.append_array(enemies)

	for node in charlist:
		node.turn_end.connect(_on_combat_menu_turn_end)
		if node is CharacterNode:
			node.combat_menu.initialize(allies, enemies)

	for enemy in enemies:
		enemy.targets = allies

	charlist[0].handle_turn()


func _get_character_node_children(node: Node) -> Array[CharacterNode]:
	var arr: Array[CharacterNode] = []
	for child in node.get_children():
		if child is CharacterNode:
			arr.append(child)
	return arr


func _get_boss_node_children(node: Node) -> Array[BossNode]:
	var arr: Array[BossNode] = []
	for child in node.get_children():
		if child is BossNode:
			arr.append(child)
	return arr


func _on_combat_menu_turn_end(character) -> void:
	if character.statuses.has(Global.Status.HASTE):
		var haste_index = character.statuses.find(Global.Status.HASTE)
		character.statuses.remove_at(haste_index)
	else:
		character.is_turn = false
		turncount += 1
		turncount %= charlist.size()
		if turncount == 0:
			for chara in charlist:
				chara.decay_effects()
		if charlist[turncount].get_stat_total(Global.Stats.HEALTH) > 0:
			charlist[turncount].handle_turn()
		else:
			# Not perfect but should work for now
			dead_characters += 1
			if dead_characters < 4:
				_on_combat_menu_turn_end(charlist[turncount])
			else:
				SignalBus.game_over.emit()


func _on_enemy_character_dead() -> void:
	SignalBus.victory.emit()
