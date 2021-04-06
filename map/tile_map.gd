extends TileMap

signal click_cell(pos)

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		var pos = world_to_map(get_global_mouse_position())
		print('----pos',pos)
		emit_signal('click_cell', pos)
