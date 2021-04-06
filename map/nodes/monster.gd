extends MapNodeBase

export(int, 2, 10) var level

# 怪物是否已经死亡
var is_dead = false

const MONSTER_DATA_DIR = "res://data/monsters"
const CombatScene = preload("res://combat/combat.tscn")

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


func visit():
	# 已经触发过了
	if !.can_trigger():
		return

	var monster_files := _get_all_monster_data_files()
	var rand_monster = monster_files[randi() % monster_files.size()]
	var monster = load(rand_monster).instance()
	var combat = CombatScene.instance()
	combat.init(monster)
	get_tree().get_root().add_child(combat)
	Global.MapIndexScene.hide()

func _get_all_monster_data_files() -> Array:
	var dir := Directory.new()
	if dir.open(MONSTER_DATA_DIR) != OK:
		printerr("Error Monster Data directory!")
		return []

	dir.list_dir_begin()
	var files := []
	var filename := dir.get_next()
	while filename != "":
		if dir.current_is_dir():
			filename = dir.get_next()
			continue

		if filename.get_extension() == "tscn":
			var filepath := dir.get_current_dir() + "/" + filename
			files.append(filepath)

		filename = dir.get_next()

	return files

func can_pass():
	return is_dead

# 打败怪物后，修改参数
func monster_dead():
	if node_visit_limit > 0:
		node_visit_limit -= 1
	is_dead = true
	$Sprite.texture = MonsterGrave

