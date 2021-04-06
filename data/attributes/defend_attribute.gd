extends AttributeModel

export(int) var defend_value

func act():
	if Global.CombatScene:
		Global.CombatScene.add_hero_defend_value(defend_value)
