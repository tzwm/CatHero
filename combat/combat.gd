extends Control
class_name Combat

export(PackedScene) var MonsterModel

var hero_attack: int
var hero_defend: int
var monster

var protect_status := false

func init(_monster):
	monster = _monster

func _ready():
	Global.CombatScene = self
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
	var hero_count = Global.heros.size()
	var min_damage = ceil(remain_damage * 0.2)
	var index = 0
	var health_min = _get_min_health()
	for hero in Global.heros:
		var damage: int
		if index == (hero_count - 1):
			damage = remain_damage
		else:
			var max_damage = remain_damage - (hero_count - index - 1) * min_damage
			damage = floor(rand_range(min_damage, max_damage))

		if protect_status && hero.health_current == health_min:
			protect_status = false
		else:	
			hero.get_damage(damage)
		remain_damage -= damage
		index += 1


func _combat_win():
	print("win")
	Global.MainPageScene.go_back_map_from_combat()

func _get_min_health() -> int:
	var min_health := 9999
	for hero in Global.heros:
		if hero.health_current < min_health:
			min_health = hero.health_current
	
	return min_health
	
func _on_NextButton_button_down():
	_end_combat()
