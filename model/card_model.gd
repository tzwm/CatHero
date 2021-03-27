extends Node
class_name CardModel

export(String) var title
export(GameConst.Character) var character
export(GameConst.CardType) var type
export(GameConst.CardRarity) var rarity
export(bool) var use_in_bonfire
export(String) var description

onready var attributes = $Attributes.get_children()

func _ready():
	pass

func act():
	for attr in attributes:
		attr.act()
