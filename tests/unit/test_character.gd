extends GutTest



func test_character_node_calc_damage():
	## Make a character with 3 strength,
	# and calculate the damage of a 2 base damage STRENGTH ability
	var char_node: Character = autofree(Character.new())
	char_node._stats[Global.Stats.STRENGTH] = 3
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
	char_node_1._stats[Global.Stats.STRENGTH] = 3
	var ability: Ability = autofree(Ability.new())
	ability.base_damage = 2
	ability.damage_attribute = Global.Stats.STRENGTH
	char_node_1.abilities.append(ability)

	var char_node_2: Character = autofree(Character.new())
	char_node_2._stats[Global.Stats.MAX_HEALTH] = 10
	char_node_2._stats[Global.Stats.HEALTH] = 10

	# This should deal 5 damage
	char_node_1.use_ability_on_target(0, [char_node_2], 0)

	assert_eq(
		char_node_2._stats[Global.Stats.HEALTH],
		5
	)


func test_ability_effect_stat_increase():
	## Add an effect to another character that lasts 2 turns and increases attack by 5
	var char_node_1: Character = autofree(Character.new())
	char_node_1._stats[Global.Stats.STRENGTH] = 3
	var effect_base: EffectBase = autofree(EffectBase.new())
	effect_base._stat_changes[Global.Stats.STRENGTH] = 5
	effect_base.max_duration = 2
	var ability: Ability = autofree(Ability.new())
	ability.effect_base = effect_base
	ability.deals_damage = false
	# this shouldn't matter, but this needs to test that the attribute doesn't
	# get added and no damage is dealt.
	ability.damage_attribute = Global.Stats.STRENGTH
	char_node_1.abilities.append(ability)

	var char_node_2: Character = autofree(Character.new())
	char_node_2._stats[Global.Stats.MAX_HEALTH] = 10
	char_node_2._stats[Global.Stats.HEALTH] = 10

	var expected_modified_stats = {
		Global.Stats.HEALTH: 10,
		Global.Stats.MAX_HEALTH: 10,
		Global.Stats.MANA: 0,
		Global.Stats.MAX_MANA: 0,
		Global.Stats.STRENGTH: 5,
		Global.Stats.DEXTERITY: 0,
		Global.Stats.SPEED: 0,
		Global.Stats.MAGIC: 0,
	}
	var expected_raw_stats = {
		Global.Stats.HEALTH: 10,
		Global.Stats.MAX_HEALTH: 10,
		Global.Stats.MANA: 0,
		Global.Stats.MAX_MANA: 0,
		Global.Stats.STRENGTH: 0,
		Global.Stats.DEXTERITY: 0,
		Global.Stats.SPEED: 0,
		Global.Stats.MAGIC: 0,
	}

	# use the ability. It should deal no damage, and apply an active effect.
	char_node_1.use_ability_on_target(0, [char_node_2], 0)

	for _num in 2:
		# 1 effect has been applied
		assert_eq(char_node_2._effects.size(), 1)
		# Stats are as expected
		for key in expected_modified_stats:
			assert_eq(char_node_2.get_stat_total(key), expected_modified_stats[key])

		# effect decays
		char_node_2.decay_effects()

	# after 2 turns
	# the effect is gone
	assert_eq(char_node_2._effects.size(), 0)
	# Effective strength is back to 0
	for key in expected_raw_stats:
		assert_eq(char_node_2.get_stat_total(key), expected_raw_stats[key])


func test_ability_effect_damage_over_time():
	## Add an effect to another character that deals 2+magic damage per turn
	var char_node_1: Character = autofree(Character.new())
	char_node_1._stats[Global.Stats.MAGIC] = 3
	var effect_base: EffectBase = autofree(EffectBase.new())
	effect_base.damage_over_time = true
	effect_base.damage = 2
	effect_base.damage_attribute = Global.Stats.MAGIC
	effect_base.max_duration = 2
	var ability: Ability = autofree(Ability.new())
	ability.effect_base = effect_base
	ability.deals_damage = false
	# this shouldn't matter, but this needs to test that the attribute doesn't
	# get added and no damage is dealt.
	ability.damage_attribute = Global.Stats.MAGIC
	char_node_1.abilities.append(ability)

	var char_node_2: Character = autofree(Character.new())
	char_node_2._stats[Global.Stats.MAX_HEALTH] = 20
	char_node_2._stats[Global.Stats.HEALTH] = 20

	var expected_modified_stats = {
		#Health changes each time
		Global.Stats.MAX_HEALTH: 20,
		Global.Stats.MANA: 0,
		Global.Stats.MAX_MANA: 0,
		Global.Stats.STRENGTH: 0,
		Global.Stats.DEXTERITY: 0,
		Global.Stats.SPEED: 0,
		Global.Stats.MAGIC: 0,
	}

	# use the ability. It should deal no damage, and apply an active effect.
	char_node_1.use_ability_on_target(0, [char_node_2], 0)

	## TURN 0
	# 1 effect has been applied
	assert_eq(char_node_2._effects.size(), 1)
	# Damage hasn't been dealt yet
	assert_eq(char_node_2.get_stat_total(Global.Stats.HEALTH), 20)
	for key in expected_modified_stats:
		assert_eq(char_node_2.get_stat_total(key), expected_modified_stats[key])

	# effect decays
	char_node_2.decay_effects()

	## TURN 1
	# 1 effect has been applied
	assert_eq(char_node_2._effects.size(), 1)
	# one damage tick
	assert_eq(char_node_2.get_stat_total(Global.Stats.HEALTH), 15)
	for key in expected_modified_stats:
		assert_eq(char_node_2.get_stat_total(key), expected_modified_stats[key])

	# effect decays
	char_node_2.decay_effects()

	## TURN 2
	# effect is gone
	assert_eq(char_node_2._effects.size(), 0)
	# two total damage ticks
	assert_eq(char_node_2.get_stat_total(Global.Stats.HEALTH), 10)
	for key in expected_modified_stats:
		assert_eq(char_node_2.get_stat_total(key), expected_modified_stats[key])
