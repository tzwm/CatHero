extends AttributeModel

export(int) var defend_value

func act():
	if Global.Combat:
		Global.Combat.add_hero_defend_value(defend_value)
