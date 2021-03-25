extends Control
class_name Card

export(PackedScene) var CardModel

onready var card = CardModel.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	card.init()
	$Panel/VBoxContainer/TopBar/Title.text = card.title
	$Panel/VBoxContainer/MarginContainer2/Description.text = card.description

func _gui_input(event):
	if event is InputEventMouseButton and event.doubleclick:
		card.act()
