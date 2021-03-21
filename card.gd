extends Control
class_name Card

export(PackedScene) var CardModel

# Called when the node enters the scene tree for the first time.
func _ready():
	var card = CardModel.instance()
	print(card.name)
	$Panel/VBoxContainer/TopBar/Title.text = card.title
	$Panel/VBoxContainer/MarginContainer2/Description.text = card.description


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
