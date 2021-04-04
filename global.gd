extends Node
#class_name Global

var Combat

var MapIndex: Node2D

# 当前关卡
var level = 1

# 玩家当前所处位置
var player_pos = Vector2(0,0)

# 重置全局参数
func reset():
	level = 1;
	player_pos = Vector2(0, 0)
