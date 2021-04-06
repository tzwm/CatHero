extends Control
class_name Card

signal play_the_card(card, index)

const CHARACTER_ASSET_DIR = "res://assets/characters/"

export(PackedScene) var CardModel

onready var card = CardModel.instance() setget _on_update_card

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _on_update_card(new_card):
#	var node_before = get_node("CardModel")
#	if node_before:
#		queue_free()
#	card = new_card
#	new_card.set_name("CardModel")
#	add_child(new_card)
	$Panel/Panel/VBoxContainer/Title.text = new_card.title
	$Panel/Panel/VBoxContainer/Description.text = new_card.description
	$Panel/Panel/VBoxContainer/HBoxContainer/CardImage/NinePatchRect.texture = new_card.avatar
	var character_name = GameConst.Character.keys()[new_card.character].to_lower()
	var character_image = load(CHARACTER_ASSET_DIR + character_name + ".png")
	$Panel/Panel/VBoxContainer/HBoxContainer/CharactorImage/TextureRect.texture = character_image
	
func _gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		emit_signal("play_the_card", card, get_index())
