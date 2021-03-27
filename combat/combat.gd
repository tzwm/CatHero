extends Control
class_name Combat

var monster : MonsterModel
var hero_attack : int
var hero_defend : int
var monster_attack : int
var monster_health : int

func _ready():
	Global.Combat = self
	var _monster_test = preload("res://data/monsters/all_monsters.tscn").instance().get_node("软泥怪")
	combat_begin(_monster_test)

func combat_begin(_monster: MonsterModel):
	monster = _monster
	monster_attack = monster.attack 
	monster_health = monster.health_current
	hero_attack = 0
	hero_defend = 0

func _process(delta):
	$VBoxContainer/MonsterAction/Attack.text = "Attack: %s" % monster_attack
	$VBoxContainer/MonsterAction/Defend.text = "Health: %s" % monster_health
	$VBoxContainer/HeroAction/Attack.text = "Attack: %s" % hero_attack
	$VBoxContainer/HeroAction/Defend.text = "Defend: %s" % hero_defend

func add_hero_attack_value(_value: int):
	hero_attack += _value

func add_hero_defend_value(_value: int):
	hero_defend += _value

