extends GutTest



func test_character_node_calc_damage():
	## Make a character with 3 strength, 
	# and calculate the damage of a 2 base damage STRENGTH ability
	var char_node: Character = autofree(Character.new())
	char_node.stats[Global.Stats.STRENGTH] = 3
	var ability: Ability = autofree(Ability.new())
	ability.base_damage = 2
	ability.damage_attribute = Global.Stats.STRENGTH
	char_node.abilities.append(ability)
	
	var char_abil = char_node.abilities[0]
	assert_eq(
		char_node.get_ability_damage(char_abil),
		5
	)


func test_combat() -> void:
	## attack a character with another character's attack
	var char_node_1: Character = autofree(Character.new())
	char_node_1.stats[Global.Stats.STRENGTH] = 3
	var ability: Ability = autofree(Ability.new())
	ability.base_damage = 2
	ability.damage_attribute = Global.Stats.STRENGTH
	char_node_1.abilities.append(ability)
	
	var char_node_2: Character = autofree(Character.new())
	char_node_2.stats[Global.Stats.MAX_HEALTH] = 10
	char_node_2.stats[Global.Stats.HEALTH] = 10
	
	# This should deal 5 damage
	char_node_1.use_ability_on_target(0, char_node_2)
	
	assert_eq(
		char_node_2.stats[Global.Stats.HEALTH], 
		5
	)
