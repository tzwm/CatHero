extends Control
class_name Combat

signal hero_add_attack(value)

var hero_attack
var hero_defend
var monster_attack
var monster_defend

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Combat_hero_add_attack(value):
	hero_attack += value
