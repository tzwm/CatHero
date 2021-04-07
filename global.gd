extends Node
#class_name Global

const MONSTER_DATA_DIR = "res://data/monsters"

# 火把数量变化
signal torch_change

# 金币数量变化
signal coin_change

# 瞭望塔
signal watch_towner

# 女巫小屋
signal witch_hut

var MainPageScene: CanvasLayer
var CombatScene: Combat

var MapIndex

var heros := []

# 队伍
var Team

# 火把数量
var torch = 10

# 金币数量
var coin = 10

# 当前关卡
var level = 0

# 怪物实例，根据等级分组
var monster_scene_map = {}

func _ready():
	var monster_path_list = _get_all_monster_data_files()
	monster_scene_map = _group_by_level(monster_path_list)
	
# 获取宝箱金币数量
func get_coin_count():
	if level == 1:
		return 6 + randi() % 3
	elif level == 2:
		return 10 + randi() % 6
	else:
		return 16 + randi() % 5
		

func new_game_level():
	if level < 3:
		level += 1
		
# 火把变化
func torch_change(count: int):
#	火把不够，压抑值+1
	if torch + count < 0:
		return false
	torch += count
	emit_signal("torch_change", torch)
	return true
	
# 金币变化
func coin_change(count: int):
	if coin + count < 0:
		return false
		
	coin += count
	emit_signal("coin_change", coin)
	return true


func _group_by_level(files: Array):
	var data = {}
	for f in files:
		var scene = load(f)
		var m  = load(f).instance()
		print(m.level)
		if data.has(m.level):
			data[m.level].append(scene)
		else:
			data[m.level] = [scene]
		m.queue_free()
	return data

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
