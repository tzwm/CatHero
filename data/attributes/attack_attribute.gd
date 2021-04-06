extends AttributeModel

export(int) var attack_value

func act():
	if Global.CombatScene:
		Global.CombatScene.add_hero_attack_value(attack_value)
