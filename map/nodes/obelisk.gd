extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
#		$CanvasLayer/Popup.popup()
		.visit()
