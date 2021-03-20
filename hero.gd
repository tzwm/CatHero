extends Control
class_name Hero

export(String) var title
export(Texture) var avatar
export(Array, PackedScene) var hand_cards

const Card = preload("res://card.tscn")

func _ready():
	var card = Card.instance()
	$Panel/VBoxContainer/HandCards.add_child(card)
