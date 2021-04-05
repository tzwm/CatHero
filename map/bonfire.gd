extends PopupDialog

func _on_Panel_rest():
	popup()


func _on_Sleep_pressed():
	var success = Global.torch_change(-3)
	if success:
		hide()
	


func _on_GoForward_pressed():
	var success = Global.torch_change(-2)
	if success:
		hide()
