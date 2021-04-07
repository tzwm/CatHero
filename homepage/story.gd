extends ColorRect

func _on_Story_gui_input(event):
	if event is InputEventMouseButton && event.pressed:
		hide()
		get_tree().change_scene("res://main_page.tscn")
