extends GutTest


func before_each():
	gut.p("ran setup", 2)


func after_each():
	gut.p("ran teardown", 2)


func before_all():
	gut.p("ran run setup", 2)


func after_all():
	gut.p("ran run teardown", 2)


func test_ability_calc_damage():
	# Calculate the damage of an ability with 2 base damage and a bonus of 3
	var ability: Ability = autofree(Ability.new())
	ability.base_damage = 2

	assert_eq(ability.get_total_damage(3), 5)
