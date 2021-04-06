extends AttributeModel

func act():
	if Global.CombatScene:
		Global.CombatScene.protect_status = true
