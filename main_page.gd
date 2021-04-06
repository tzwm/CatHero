extends CanvasLayer

const Combat = preload("res://combat/combat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.MainPageScene = self
	for hero_node in $VBoxContainer/Team/CenterContainer/Heroes.get_children():
		Global.heros.append(hero_node.hero)


func enter_combat(monster):
	var combat = Combat.instance()
	combat.init(monster)
	$VBoxContainer/MarginContainer.add_child(combat)
	$VBoxContainer/MarginContainer/GameMap.hide()

func go_back_map_from_combat():
	for node in $VBoxContainer/MarginContainer.get_children():
		if node.is_visible_in_tree():
			node.queue_free()
		else:
			node.show()
