class_name Card
extends Area2D

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

export var title : String
export(GameConst.Character) var character
export var description : String


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/TopBar/Title.text = title
	$Control/VBoxContainer/MarginContainer2/Description.text = description


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
