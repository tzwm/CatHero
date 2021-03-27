extends Node
class_name CardModel

export(String) var title
export(GameConst.Character) var character
export(String) var description

onready var attributes = $Attributes.get_children()

func _ready():
	pass

func act():
	for attr in attributes:
		attr.act()
