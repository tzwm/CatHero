extends Node
class_name CardModel

export(String) var title
export(GameConst.Character) var character
export(String) var description

var attributes : Array

func _ready():
	attributes = $Attributes.get_children()
