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

var Combat

var MapIndex: Node2D

# 火把数量
var torch = 10

# 金币数量
var coin = 10

# 压抑值
var depress = 0

# 当前关卡
var level = 1

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
	level = 1;
	player_pos = Vector2(0, 0)


func torch_change(count: int):
	if torch + count < 0:
		return false
	torch += count
	emit_signal("torch_change", torch)
	return true
	
func coin_change(count: int):
	if coin + count < 0:
		return false
		
	coin += count
	emit_signal("coin_change", torch)
	return true
	
	
	
