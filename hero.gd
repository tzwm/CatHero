extends Control
class_name Hero

const Card = preload("res://card.tscn")
const CHARACTER_ASSET_DIR = "res://assets/characters/"

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

	for node in $Panel/VBoxContainer/Panel/HandCards.get_children():
		node.queue_free()
	for card_node in new_hand_card_nodes:
		$Panel/VBoxContainer/Panel/HandCards.add_child(card_node)

func _update_hero_view() -> void:
	var character_name = GameConst.Character.keys()[hero.character].to_lower()
	var character_image = load(CHARACTER_ASSET_DIR + character_name + ".png")
	$Panel/VBoxContainer/HBoxContainer/Avatar.texture = character_image
	$Panel/VBoxContainer/HBoxContainer/Health.text = "HP %s/%s" % [hero.health_current, hero.health_max]
	$Panel/VBoxContainer/HBoxContainer/Exp.text = "EXP %s" % [hero.exp_current]
	
	if $Panel/VBoxContainer/Stress.get_child_count() == hero.stress_current:
		return
	for node in $Panel/VBoxContainer/Stress/HBoxContainer.get_children():
		node.queue_free()
	for i in range(hero.stress_current):
		var node = TextureRect.new()
		node.texture = load("res://assets/art/ui/压抑值.png")
		node.expand = true
		node.rect_min_size.y = 40
		node.rect_min_size.x = 40
		$Panel/VBoxContainer/Stress/HBoxContainer.add_child(node)
	
func _on_play_the_card(card : CardModel, index : int) -> void:
	hero.play_the_card(card, index)
