extends AttributeModel

export(int) var attack_value

func act():
	emit_signal("hero_add_attack", attack_value)
