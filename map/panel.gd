extends VBoxContainer

signal move
signal rest

func set_info(name, desc):
	$Info/Name.text = name
	$Info/Desc.text = desc
	
func _on_Go_pressed():
	emit_signal('move')

func _on_Rest_pressed():
	emit_signal('rest')


	
