extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


### THESE ARE TEMPORARY, REPLACE THESE EVENTUALLY
func update_labels() -> void:
	var player: CharacterNode = $PlayableCharacter
	var boss: CharacterNode = $EnemyCharacter

	$EnemyCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			boss.stats[Global.stats.HEALTH],
			boss.stats[Global.stats.MAX_HEALTH],
			boss.stats[Global.stats.MANA],
			boss.stats[Global.stats.MAX_MANA],
			boss.stats[Global.stats.STRENGTH],
			boss.stats[Global.stats.DEXTERITY],
			boss.stats[Global.stats.MAGIC],
			boss.stats[Global.stats.SPEED]
		]
	)

	$PlayableCharacter/Label.text = (
		("HP: %d/%d\n" + "MP: %d/%d\n" + "STR: %d\n" + "DEX: %d\n" + "MAG: %d\n" + "SPD: %d")
		% [
			player.stats[Global.stats.HEALTH],
			player.stats[Global.stats.MAX_HEALTH],
			player.stats[Global.stats.MANA],
			player.stats[Global.stats.MAX_MANA],
			player.stats[Global.stats.STRENGTH],
			player.stats[Global.stats.DEXTERITY],
			player.stats[Global.stats.MAGIC],
			player.stats[Global.stats.SPEED]
		]
	)


func attack_with_ability(num: int):
	var player: CharacterNode = $PlayableCharacter
	var boss: CharacterNode = $EnemyCharacter

	player.use_ability_on_target(num, boss)
	update_labels()


func _on_attack_test_pressed() -> void:
	attack_with_ability(0)


func _on_magic_test_pressed() -> void:
	attack_with_ability(1)
