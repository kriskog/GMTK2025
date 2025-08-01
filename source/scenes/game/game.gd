extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayableCharacter.is_turn = true
	update_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_labels()


### THESE ARE TEMPORARY, REPLACE THESE EVENTUALLY
func update_labels() -> void:
	var player: CharacterNode = $PlayableCharacter
	var boss: CharacterNode = $EnemyCharacter

	$EnemyCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			boss.stats[Global.Stats.HEALTH],
			boss.stats[Global.Stats.MAX_HEALTH],
			boss.stats[Global.Stats.MANA],
			boss.stats[Global.Stats.MAX_MANA],
			boss.stats[Global.Stats.STRENGTH],
			boss.stats[Global.Stats.DEXTERITY],
			boss.stats[Global.Stats.MAGIC],
			boss.stats[Global.Stats.SPEED]
		]
	)

	$PlayableCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			player.stats[Global.Stats.HEALTH],
			player.stats[Global.Stats.MAX_HEALTH],
			player.stats[Global.Stats.MANA],
			player.stats[Global.Stats.MAX_MANA],
			player.stats[Global.Stats.STRENGTH],
			player.stats[Global.Stats.DEXTERITY],
			player.stats[Global.Stats.MAGIC],
			player.stats[Global.Stats.SPEED]
		]
	)
