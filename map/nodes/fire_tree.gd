extends MapNodeBase

const FireTreeUsed = preload("res://assets/art/nodes/火树2.png")

func visit():
	var can = .can_trigger()
	if can:
		Global.torch_change(3 + randi() % 2)
		$Sprite.texture = FireTreeUsed;
		.visit()
