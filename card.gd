extends Area2D
class_name Card

enum CardType {
	ATTACK,
	DEFEND,
	SKILL,
	CURSE,
}

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
}

export(String) var title
export(GameConst.Character) var character
export(String) var description


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Panel/VBoxContainer/TopBar/Title.text = title
	$Control/Panel/VBoxContainer/MarginContainer2/Description.text = description


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
