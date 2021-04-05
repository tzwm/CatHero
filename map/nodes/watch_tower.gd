extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
		Global.emit_signal("watch_towner", node_pos)
		.visit()
	
