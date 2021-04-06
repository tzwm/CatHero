extends Node
#class_name Global

# 火把数量变化
signal torch_change

# 金币数量变化
signal coin_change

# 瞭望塔
signal watch_towner

# 女巫小屋
signal witch_hut


var CombatScene: Combat

var MapIndex

# 队伍
var Team

# 火把数量
var torch = 10

# 金币数量
var coin = 10

# 当前关卡
var level = 0

# 玩家当前所处位置
var player_pos = Vector2(0,0)

# 获取宝箱金币数量
func get_coin_count():
	if level == 1:
		return 6 + randi() % 3
	elif level == 2:
		return 10 + randi() % 6
	else:
		return 16 + randi() % 5
		

# 重置全局参数
func reset():
	level = 0;
	player_pos = Vector2(0, 0)

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

	
