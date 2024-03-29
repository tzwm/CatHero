extends MapNodeBase

export(int, 2, 10) var level

# 怪物是否已经死亡
var is_dead = false

const MonsterModel = preload("res://model/monster_model.tscn")


var monster: MonsterModel


const Monster2 = preload("res://assets/art/nodes/怪物2.png")
const Monster3 = preload("res://assets/art/nodes/怪物3.png")
const Monster4 = preload("res://assets/art/nodes/怪物4.png")
const Monster5 = preload("res://assets/art/nodes/怪物5.png")
const Monster6 = preload("res://assets/art/nodes/怪物6.png")
const Monster7 = preload("res://assets/art/nodes/怪物7.png")
const Monster8 = preload("res://assets/art/nodes/怪物8.png")
const Monster9 = preload("res://assets/art/nodes/怪物9.png")
const Monster10 = preload("res://assets/art/nodes/怪物10.png")

const MonsterGrave = preload("res://assets/art/nodes/怪物墓碑.png")


const TextureMap = {
	2: Monster2,
	3: Monster3,
	4: Monster4,
	5: Monster5,
	6: Monster6,
	7: Monster7,
	8: Monster8,
	9: Monster9,
	10: Monster10
}
func set_monster_level(l: int):
	level = l
	$Sprite.texture = TextureMap[l]
	
	var monster_list = []
	if Global.monster_scene_map.has(l):
		monster_list = Global.monster_scene_map[l]
	else:
		monster_list = Global.monster_scene_map[2]
		
	monster = monster_list[randi() % monster_list.size()].instance()
	node_desc += monster.name
	
	monster.connect("fight_end", self, "_on_Fight_end")

func visit():
	# 已经触发过了
	if !.can_trigger():
		return
		
	Global.MainPageScene.enter_combat(monster)
	#Global.MapIndex.hide()


func can_pass():
	return is_dead 
	
# 打败怪物后，修改参数
func monster_dead():
	if node_visit_limit > 0:
		node_visit_limit -= 1
	is_dead = true
	$Sprite.texture = MonsterGrave
	node_desc = "怪物" + monster.name + "被打败了"
	
func _on_Fight_end():
	monster_dead()
