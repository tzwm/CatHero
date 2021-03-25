extends Control
class_name Hero

const Card = preload("res://card.tscn")

export(PackedScene) var HeroModel
onready var hero = HeroModel.instance()

func _ready():
	add_child(hero)
	$Panel/VBoxContainer/HBoxContainer/Avatar.texture = hero.avatar
	$Panel/VBoxContainer/HBoxContainer/Nickname.text = hero.nickname

func _process(delta):
	_update_hand_cards_view()
	
func _update_hand_cards_view() -> void:
	var new_hand_card_nodes := []
	for card in hero.deck_hand:
		var card_node = Card.instance()
		card_node.card = card
		new_hand_card_nodes.push_back(card_node)

	for node in $Panel/VBoxContainer/HandCards.get_children():
		node.queue_free()
	for card_node in new_hand_card_nodes:
		$Panel/VBoxContainer/HandCards.add_child(card_node)
