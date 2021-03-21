extends RigidBody2D

class_name MapNode

# 节点类型
enum NodeTypeEnum {
	# 空
	EMPTY,
	# 怪物
	MONSTER, 
	# 商人
	BUSINESS_MAN,
	# 学者
	SCHOLAR,
	# 苦行僧
	ASCETIC_MONK,
	# 宝箱
	TREASURE,
	# 瞭望塔
	WATCH_TOWER,
	# 火树
	FIRE_TREE,
	# 方尖碑
	OBELISK,
	# 神庙
	TEMPLE,
	# 女巫小屋
	WITCH_HUT,
	# 起点
	STARTING_POINT,
	# 终点
	DESTINATION
}
# 节点类型
export(NodeTypeEnum) var node_type

# 节点名称
export(String) var node_name

# 节点描述
export(String, MULTILINE) var node_desc

enum NodeVisibleEnum {
	NO = 0,
	YES = 1
}
# 是否可见
export(NodeVisibleEnum) var node_visible


enum NodeRarityEnum {
	NORMAL = 1,
	RARE = 2,
	SUPER_RARE = 3,
	SUPERIOR_SUPER_RARE
}

# 稀有度
export(NodeRarityEnum) var node_rarity

# 节点图标
export(Resource) var node_icon

# 坐标
var x
var y

# 下一步的可选节点
var next_node_list = []

func _ready():
	pass # Replace with function body.

func _init(_x: int, _y: int, type: int):
	x = _x
	y = _y
	node_type = type

# 添加下一个节点
func add_next_node(_x: int, _y: int):
	if(!next_node_list.has(Vector2(_x, _y))):
		next_node_list.append(Vector2(_x, _y))
		
# 设置节点类型
func set_node_type(_type: int):
	node_type = _type
