extends Control
class_name Card

signal play_the_card(card, index)

export(PackedScene) var CardModel

onready var card = CardModel.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(card)
	$Panel/VBoxContainer/TopBar/Title.text = card.title
	$Panel/VBoxContainer/MarginContainer2/Description.text = card.description

func _gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		emit_signal("play_the_card", card, get_index())
