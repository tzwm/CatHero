extends AttributeModel

export(int) var attack_value

func act():
	if Global.Combat:
		Global.Combat.add_hero_attack_value(attack_value)
	#emit_signal("add_attack_value", attack_value)
