extends TileMap

signal click_cell(pos)

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		var pos = world_to_map(get_global_mouse_position())
		emit_signal('click_cell', pos)
		
