extends MapNodeBase

export(int, 1, 10) var level

func set_monster_level(l: int):
	level = l

	
func _on_MapNodeBase_body_entered(body):
	print('-----', body, level)
