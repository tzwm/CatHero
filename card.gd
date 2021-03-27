extends Control
class_name Card

signal play_the_card(card, index)

export(PackedScene) var CardModel

onready var card = CardModel.instance() setget _on_update_card

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_update_card(new_card):
	card = new_card
	add_child(new_card)
	$Panel/VBoxContainer/TopBar/Title.text = new_card.title
	$Panel/VBoxContainer/MarginContainer2/Description.text = new_card.description
	
func _gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		emit_signal("play_the_card", card, get_index())
