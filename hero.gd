extends Control
class_name Hero

const Card = preload("res://card.tscn")

export(PackedScene) var HeroModel
onready var hero = HeroModel.instance()

func _ready():
	add_child(hero)
	_update_hero_view()
	_update_hand_cards_view()

func _process(delta):
	_update_hero_view()
	#TODO(tzwm): 我先不管性能了，每帧都直接刷新了
	_update_hand_cards_view()

func _update_hand_cards_view() -> void:
	var new_hand_card_nodes := []
	for card in hero.deck_hand:
		var card_node = Card.instance()
		card_node.card = card
		card_node.connect("play_the_card", self, "_on_play_the_card")
		new_hand_card_nodes.push_back(card_node)

	for node in $Panel/VBoxContainer/HandCards.get_children():
		node.queue_free()
	for card_node in new_hand_card_nodes:
		$Panel/VBoxContainer/HandCards.add_child(card_node)

func _update_hero_view() -> void:
	$Panel/VBoxContainer/HBoxContainer/Avatar.texture = hero.avatar
	$Panel/VBoxContainer/HBoxContainer/Nickname.text = hero.nickname
	$Panel/VBoxContainer/HBoxContainer/Health.text = "%s/%s" % [hero.health_current, hero.health_max]
	
func _on_play_the_card(card : CardModel, index : int) -> void:
	hero.play_the_card(card, index)
