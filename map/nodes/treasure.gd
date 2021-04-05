extends MapNodeBase

const TreasureUsed = preload("res://assets/art/nodes/宝箱2.png")

func visit():
	var can = .can_trigger()
	if can:
		$Sprite.texture = TreasureUsed;
		# TODO 需要随机金币或者遗物
		Global.coin_change(Global.get_coin_count())
		.visit()
	
