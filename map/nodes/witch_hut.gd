extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
		Global.emit_signal("witch_hut")
		.visit()
	
