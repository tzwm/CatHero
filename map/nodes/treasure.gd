extends MapNodeBase

const TreasureUsed = preload("res://assets/art/nodes/宝箱2.png")

func _on_MapNodeBase_body_entered(body):
	var can = .can_trigger()
	if can:
		$Sprite.texture = TreasureUsed;
	._on_MapNodeBase_body_entered(body)
	
