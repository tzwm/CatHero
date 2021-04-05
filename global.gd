extends Node
#class_name Global

# 火把数量变化
signal change_torch

var Combat

var MapIndex: Node2D

# 火把数量
var torch = 10

# 当前关卡
var level = 1

# 玩家当前所处位置
var player_pos = Vector2(0,0)

# 重置全局参数
func reset():
	level = 1;
	player_pos = Vector2(0, 0)


	
