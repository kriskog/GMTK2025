extends Node

var turncount
var charlist = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayableCharacter.is_turn = true
	update_labels()
	turncount = 0
	fill_charlist()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_labels()


func fill_charlist() -> void:
	charlist.append($PlayableCharacter)
	charlist.append($PlayableCharacter2)
	charlist.append($PlayableCharacter3)
	charlist.append($PlayableCharacter4)


func _on_combat_menu_turn_end(character) -> void:
	if character.is_hasted:
		character.is_hasted = false  #not implemented
	else:
		character.is_turn = false
		if character == charlist[3]:
			#boss.turn() #not implemented
			turncount = 0
		else:
			turncount += 1
		if character.get_stat_total(Global.Stats.HEALTH) > 0:
			charlist[turncount].is_turn = true
		else:
			while charlist[turncount].get_stat_total(Global.Stats.HEALTH) <= 0:
				if turncount == 3:
					turncount = 0
				else:
					turncount += 1
			charlist[turncount].is_turn = true


### THESE ARE TEMPORARY, REPLACE THESE EVENTUALLY
func update_labels() -> void:
	var player: CharacterNode = $PlayableCharacter
	var boss: CharacterNode = $EnemyCharacter

	$EnemyCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			boss.get_stat_total(Global.Stats.HEALTH),
			boss.get_stat_total(Global.Stats.MAX_HEALTH),
			boss.get_stat_total(Global.Stats.MANA),
			boss.get_stat_total(Global.Stats.MAX_MANA),
			boss.get_stat_total(Global.Stats.STRENGTH),
			boss.get_stat_total(Global.Stats.DEXTERITY),
			boss.get_stat_total(Global.Stats.MAGIC),
			boss.get_stat_total(Global.Stats.SPEED)
		]
	)

	$PlayableCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			player.get_stat_total(Global.Stats.HEALTH),
			player.get_stat_total(Global.Stats.MAX_HEALTH),
			player.get_stat_total(Global.Stats.MANA),
			player.get_stat_total(Global.Stats.MAX_MANA),
			player.get_stat_total(Global.Stats.STRENGTH),
			player.get_stat_total(Global.Stats.DEXTERITY),
			player.get_stat_total(Global.Stats.MAGIC),
			player.get_stat_total(Global.Stats.SPEED)
		]
	)
