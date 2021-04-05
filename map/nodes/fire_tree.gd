extends MapNodeBase

const FireTreeUsed = preload("res://assets/art/nodes/火树2.png")

func _on_MapNodeBase_body_entered(body):
	var can = .can_trigger()
	if can:
		Global.torch +=  3 + randi() % 2
		Global.emit_signal("change_torch", Global.torch)
		$Sprite.texture = FireTreeUsed;
	._on_MapNodeBase_body_entered(body)
	
