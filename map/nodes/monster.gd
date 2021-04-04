extends MapNodeBase

export(int, 1, 10) var level

const MONSTER_DATA_DIR = "res://data/monsters"
const Combat = preload("res://combat/combat.tscn")

func set_monster_level(l: int):
	level = l


func _on_MapNodeBase_body_entered(body):
	var monster_files := _get_all_monster_data_files()
	var monster = load(monster_files[randi() % monster_files.size()]).instance()
	var combat = Combat.instance()
	combat.init(monster)
	get_tree().get_root().add_child(combat)
	
	Global.MapIndex.visible = false

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
