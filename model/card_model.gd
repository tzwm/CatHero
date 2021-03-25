extends Node
class_name CardModel

export(String) var title
export(GameConst.Character) var character
export(String) var description

var attributes : Array

func init():
	attributes = $Attributes.get_children()
	for attr in attributes:
		attr.init()

func act():
	for attr in attributes:
		attr.act()
