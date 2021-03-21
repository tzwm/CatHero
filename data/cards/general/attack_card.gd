extends CardModel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func act():
	for _attr in attributes:
		_attr.act()
