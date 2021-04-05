extends MapNodeBase

export(int, 1, 10) var level

const MONSTER_DATA_DIR = "res://data/monsters"
const Combat = preload("res://combat/combat.tscn")

const Monster2 = preload("res://assets/art/nodes/怪物2.png")
const Monster3 = preload("res://assets/art/nodes/怪物3.png")
const Monster4 = preload("res://assets/art/nodes/怪物4.png")
const Monster5 = preload("res://assets/art/nodes/怪物5.png")
const Monster6 = preload("res://assets/art/nodes/怪物6.png")
const Monster7 = preload("res://assets/art/nodes/怪物7.png")
const Monster8 = preload("res://assets/art/nodes/怪物8.png")
const Monster9 = preload("res://assets/art/nodes/怪物9.png")
const Monster10 = preload("res://assets/art/nodes/怪物10.png")

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


func _on_MapNodeBase_body_entered(_body):
#	var monster_files := _get_all_monster_data_files()
#	var monster = load(monster_files[randi() % monster_files.size()]).instance()
#	var combat = Combat.instance()
#	combat.init(monster)
#	get_tree().get_root().add_child(combat)
#	Global.MapIndex.hide()
	pass

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
