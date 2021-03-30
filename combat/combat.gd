extends Control
class_name Combat

export(PackedScene) var MonsterModel

var hero_attack: int
var hero_defend: int
var monster

func init(_monster):
	monster = _monster

func _ready():
	Global.Combat = self
	if !monster:
		monster = MonsterModel.instance()

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

func _end_combat():
	if hero_attack >= monster.health_current:
		monster.health_current = 0
		_combat_win()
		return

	monster.health_current -= hero_attack
	var remain_damage = monster.attack - hero_defend
	var hero_count = $VBoxContainer/Team/Heroes.get_child_count()
	var min_damage = ceil(remain_damage * 0.2)
	var index = 0
	for hero_node in $VBoxContainer/Team/Heroes.get_children():
		var damage: int
		if index == (hero_count - 1):
			damage = remain_damage
		else:
			var max_damage = remain_damage - (hero_count - index - 1) * min_damage
			damage = floor(rand_range(min_damage, max_damage))

		hero_node.hero.get_damage(damage)
		remain_damage -= damage
		index += 1


func _combat_win():
	print("win")


func _on_NextButton_button_down():
	_end_combat()
