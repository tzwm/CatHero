extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
		Global.Team.give_one_card()
		.visit()
