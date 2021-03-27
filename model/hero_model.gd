extends Node
class_name HeroModel

export(String) var nickname
export(Texture) var avatar
export(GameConst.Character) var character

const HAND_LIMIT = 3

export(Array, PackedScene) var deck_built
var deck_hand : Array
var deck_exhausted : Array
var deck_unused : Array

func _ready():
	for c in deck_built:
		var cc = c.instance()
		#cc.init()
		deck_unused.push_back(cc)
		
	_draw_a_card()
	yield(get_tree().create_timer(1.0), "timeout")
	_draw_a_card()

func play_the_card(card, index):
	deck_hand.remove(index)
	deck_exhausted.push_back(card)
	card.act()

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

