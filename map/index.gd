extends Node2D

onready var tile_map = $TileMap

const MapNode = preload("node.gd")

# 地图尺寸
const map_size = Vector2(7, 7)
# 关卡格子尺寸
const map_with_road_size = Vector2(2 * map_size.x - 1, 2 * map_size.y - 1)
# 关卡节点数据
const map_node_data = []
# 关卡地图，带道路
const map_data = []

# 当前关卡
const level = 1

# 起点位置
const starting_points = {
	1: [Vector2(5,5),Vector2(5,6),Vector2(6,5),Vector2(6,6)],
	2: [Vector2(5,5),Vector2(5,6),Vector2(6,5),Vector2(6,6)],
	3: [Vector2(6,6)]
}

# 终点位置
const destinations = {
	1: [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0, 3),Vector2(1, 0), Vector2(2, 0),Vector2(3, 0)],
	2: [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0, 3),Vector2(1, 0), Vector2(2, 0),Vector2(3, 0)],
	3: [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0, 3),Vector2(1, 0), Vector2(2, 0),Vector2(3, 0)],
}

enum Tile {
	None = 0, 
	Monster = 2,
	RoadH = 3, 
	RoadV = 4, 
	RoadRT = 5, 
	RoadLT = 6, 
	RoadCross = 7, 
}

func _ready():
	new_game()


# 获取某个点周围的所有点
# 从左上角开始，顺时针一周，处理可能越界的点
# [x-1,y-1] [x , y-1] [x+1,y-1]
# [x-1,y  ] [x , y  ] [x+1,y  ]
# [x-1,y+1] [x , y+1] [x+1,y+1]
func get_around_point(x, y):
	var list = []
	if x-1 >= 0 && y-1 >= 0:
		list.append(Vector2(x-1, y-1))
	if y-1 >=0:
		list.append(Vector2(x, y-1))
	if x+1 < map_size.x && y-1 >=0:
		list.append(Vector2(x+1, y-1))
	if x+1 < map_size.x:
		list.append(Vector2(x+1, y))
	if x+1 < map_size.x && y+1 < map_size.y:
		list.append(Vector2(x+1, y+1))
	if 	y+1 < map_size.y:
		list.append(Vector2(x, y+1))
	if x-1 >=0 && y+1< map_size.y:
		list.append(Vector2(x-1, y+1))
	if x-1>=0:
		list.append(Vector2(x-1, y))
	return list
	
# 从数组中随机取n个元素
func rand_from_array(arr: Array, num: int):
	
	if(num >= arr.size()):
		return arr;
	var new_arr = []
	
	for i in num:
		var r = randi_range(0, arr.size())
		new_arr.append(arr[r])
		arr.remove(r)
	return new_arr

# 生成 from 到 to 之间的整数
func randi_range(from: int, to: int):
	return randi() % (to - from) + from
	
# 计算单个节点和周围节点的关系，并随机连接
func calc_node_connection(x, y):
	# 当前节点
	var current_node = map_node_data[x][y]
	
	# 获取周围坐标列表
	var point_list = get_around_point(x, y)
	
	# 从候选的邻居节点中，删除已经连接的节点
	for next_point in current_node.next_node_list:
		var index = point_list.find(next_point)
		if index > -1:
			point_list.remove(index)
	
	# 连接该节点的节点数量
	var node_count = current_node.next_node_list.size()
	# 约定连接节点数量在2到4之间，去除掉已经存在的节点，剩下需要生成的数量
	var need_count  = max(0, randi_range(2, 4) - node_count)
	# 需要连接的点的坐标
	var connect_point = rand_from_array(point_list, need_count)
	
	for point in connect_point:
		# 邻居节点
		var node = map_node_data[point.x][point.y]
		current_node.add_next_node(node.x, node.y)
		node.add_next_node(x, y)


# 根据节点间关系，生成路径
func create_road(x: int, y: int):
	# 当前节点
	var current_node = map_node_data[x][y]
	
	map_data[2*x][2*y] = Tile.Monster
	
	# 计算道路
	for point in current_node.next_node_list:
		var offset_x = point.x + x
		var offset_y = point.y + y
		
		# 水平 ——
		if point.x == x:
			map_data[offset_x][offset_y] = Tile.RoadV
		# 垂直 |
		elif point.y == y:
			map_data[offset_x][offset_y] = Tile.RoadH
		# 左上角到右下角 \
		elif (point.x - x)*(point.y - y) > 0:
			if map_data[offset_x][offset_y] == 0:
				map_data[offset_x][offset_y] = Tile.RoadLT
			elif map_data[offset_x][offset_y] != Tile.RoadLT:
				map_data[offset_x][offset_y] = Tile.RoadCross
		# 右上角到左下角 /
		else:
			if map_data[offset_x][offset_y] == 0:
				map_data[offset_x][offset_y] = Tile.RoadRT
			elif map_data[offset_x][offset_y] != Tile.RoadRT:
				map_data[offset_x][offset_y] = Tile.RoadCross
		
	
# 创建起点和终点
func create_start_and_end():
	var s_points = starting_points[level]
	var s_index = randi_range(0, s_points.size())
	var start_point = s_points[s_index]
	
	map_node_data[start_point.x][start_point.y].set_node_type(MapNode.NodeTypeEnum.STARTING_POINT)
	var d_points = destinations[level]
	
	var d_index = randi_range(0, d_points.size())
	var end_point = destinations[level][d_index]
	map_node_data[start_point.x][start_point.y].set_node_type(MapNode.NodeTypeEnum.DESTINATION)
	
# 
func random_node_type():
	pass
	
# 生成节点的类型
func create_node_role(x: int, y: int):
	var node = map_node_data[x][y]
	if node.node_type != MapNode.NodeTypeEnum.EMPTY:
		pass
	
	
func create_map(): 
	map_data.clear()
	map_node_data.clear()
	
	randomize()
	
	# 初始化地图数据，有路径信息
	for x in map_with_road_size.x:
		map_data.append([])
		for y in map_with_road_size.y:
			map_data[x].append(0)
			
	# 生成初始地图节点
	for x in map_size.x:
		map_node_data.append([])
		for y in map_size.y:
			var node = MapNode.new(x, y, MapNode.NodeTypeEnum.EMPTY)
			map_node_data[x].append(node)	
	
	# 生成节点间的连接关系
	for x in map_size.x:
		for y in map_size.y:
			calc_node_connection(x, y)
	
	# 生成路径
	for x in map_size.x:
		for y in map_size.y:
			create_road(x, y)
	
	# 渲染路径和节点
	for x in range(
		map_with_road_size.x):
		for y in range(map_with_road_size.y):
			tile_map.set_cell(x, y, map_data[x][y])

func new_game():
	create_map()


func end_game():
	# 销毁地图节点
	get_tree().call('map_points', 'queue_free')
