extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
		Global.Team.take_one_card()
		.visit()
