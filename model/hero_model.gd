extends Node
class_name HeroModel

const HAND_LIMIT = 3

export(String) var nickname
export(Texture) var avatar
export(GameConst.Character) var character
export(int) var health_max

onready var health_current = health_max
var exp_current := 0

onready var deck_built = $DeckBuilt.get_children()
var deck_hand : Array
var deck_exhausted : Array
var deck_unused : Array

func _ready():
	deck_unused = deck_built.duplicate(true)
	deck_unused.shuffle()

	_draw_a_card()
	yield(get_tree().create_timer(1.0), "timeout")
	_draw_a_card()

func play_the_card(card, index):
	var c = deck_hand[index]
	deck_hand.remove(index)
	deck_exhausted.push_back(c)
	c.act()

func get_damage(value):
	health_current -= value

func _draw_a_card() -> void:
	if deck_hand.size() >= HAND_LIMIT:
		return

	if deck_unused.size() == 0:
		if deck_exhausted.size() == 0:
			return

		deck_unused = deck_exhausted
		deck_unused.shuffle()
		deck_exhausted = []

	deck_hand.push_back(deck_unused.pop_back())

