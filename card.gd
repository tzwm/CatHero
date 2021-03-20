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

var key : String
var title : String
var character : int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
