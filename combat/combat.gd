extends Control
class_name Combat

export(PackedScene) var MonsterModel
onready var monster = MonsterModel.instance()
var hero_attack : int
var hero_defend : int

func _ready():
	Global.Combat = self
	add_child(monster)
	hero_attack = 0
	hero_defend = 0

func _process(delta):
	$VBoxContainer/Top/MonsterAvatar.texture = monster.avatar
	$VBoxContainer/MonsterAction/Attack.text = "Attack: %s" % monster.attack
	$VBoxContainer/MonsterAction/Health.text = "Health: %s" % monster.health_current
	$VBoxContainer/HeroAction/Attack.text = "Attack: %s" % hero_attack
	$VBoxContainer/HeroAction/Defend.text = "Defend: %s" % hero_defend

func add_hero_attack_value(_value: int):
	hero_attack += _value

func add_hero_defend_value(_value: int):
	hero_defend += _value

