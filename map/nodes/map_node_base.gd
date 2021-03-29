extends Area2D

class_name MapNodeBase

const GameConst = preload('res://game_const.gd')


# 节点类型
export(GameConst.NodeTypeEnum) var node_type

# 节点名称
export(String) var node_name

# 节点描述
export(String, MULTILINE) var node_desc

# 是否可见
export(bool) var node_visible

# 格子坐标
export(Vector2) var node_pos

# 是否已经被访问过
export(bool) var node_visited

# 下一步的可选节点
var next_node_list = []



# 添加下一个节点
func add_next_node(pos: Vector2):
	if(!next_node_list.has(pos)):
		next_node_list.append(pos)
		
# 设置节点类型
func set_node_type(_type: int):
	node_type = _type

func set_visible(state: bool): 
	node_visible = state
	$Sprite.visible = state
	
func _on_MapNodeBase_body_entered(body):
	print(body, node_type)
