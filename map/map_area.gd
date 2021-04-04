extends ViewportContainer

signal node_selected

onready var tile_map = $Viewport/TileMap

onready var player = $Viewport/Player

const GameConst = preload("res://game_const.gd")

const Empty = preload("res://map/nodes/empty.tscn")
const Monster = preload("res://map/nodes/monster.tscn")
const BusinessMan = preload("res://map/nodes/business_man.tscn")
const Scholar = preload("res://map/nodes/scholar.tscn")
const AsceticMonk = preload("res://map/nodes/ascetic_monk.tscn")
const Treasure = preload("res://map/nodes/treasure.tscn")
const WatchTowner = preload("res://map/nodes/watch_tower.tscn")
const FireTree = preload("res://map/nodes/fire_tree.tscn")
const Obelisk = preload("res://map/nodes/obelisk.tscn")
const Temple = preload("res://map/nodes/temple.tscn")
const WitchHut = preload("res://map/nodes/witch_hut.tscn")
const StartingPoint = preload("res://map/nodes/starting_point.tscn")
const Destination = preload("res://map/nodes/destination.tscn")

const scene_map = {
	GameConst.NodeTypeEnum.EMPTY: Empty,
	GameConst.NodeTypeEnum.MONSTER: Monster,
	GameConst.NodeTypeEnum.BUSINESS_MAN: BusinessMan,
	GameConst.NodeTypeEnum.SCHOLAR: Scholar,
	GameConst.NodeTypeEnum.ASCETIC_MONK: AsceticMonk,
	GameConst.NodeTypeEnum.TREASURE: Treasure,
	GameConst.NodeTypeEnum.WATCH_TOWER: WatchTowner,
	GameConst.NodeTypeEnum.FIRE_TREE: FireTree,
	GameConst.NodeTypeEnum.OBELISK: Obelisk,
	GameConst.NodeTypeEnum.TEMPLE: Temple,
	GameConst.NodeTypeEnum.WITCH_HUT: WitchHut,
	GameConst.NodeTypeEnum.STARTING_POINT: StartingPoint,
	GameConst.NodeTypeEnum.DESTINATION: Destination,
}

# 地图尺寸
const map_size = Vector2(7, 7)
# 关卡格子尺寸
const map_with_road_size = Vector2(2 * map_size.x - 1, 2 * map_size.y - 1)
# 关卡节点数据
const map_node_data = []
# 关卡地图，带道路
const map_data = []

# 可见区域范围
const visible_area = 1

# 格子像素
const map_cell_size = 64

var selected_node = Vector2(0,0)

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

# 怪物等级
const monster_level_range = {
	1: [1,6],
	2: [3,8],
	3: [5,10],
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
	var rect = get_rect()
	$Viewport.size = rect.size

	
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
	
# 将节点位置映射到地图单元格位置
func node_to_cell(pos):
	return pos * 2

# 将节点的位置，隐射到全局坐标
func node_to_position(node_pos):
	var cell_pos = node_to_cell(node_pos)
	var pos = tile_map.map_to_world(cell_pos)
	pos.x += map_cell_size / 2
	pos.y += map_cell_size / 2
	return pos
	
# 将地图单元格位置映射到节点位置	
func cell_to_node(pos):
	return pos / 2
	
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
		current_node.add_next_node(node.node_pos)
		node.add_next_node(Vector2(x, y))
	
# 根据节点间关系，生成路径
func create_road(x: int, y: int):
	# 当前节点
	var current_node = map_node_data[x][y]
	
	var tile_id = tile_map.tile_set.find_tile_by_name('map_node_base')
#	
	map_data[2*x][2*y] = tile_id
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
	var s_points = starting_points[Global.level]
	var s_index = randi_range(0, s_points.size())
	var start_point = s_points[s_index]
	map_node_data[start_point.x][start_point.y] = GameConst.NodeTypeEnum.STARTING_POINT
	
	var d_points = destinations[Global.level]
	
	var d_index = randi_range(0, d_points.size())
	var end_point = destinations[Global.level][d_index]
	map_node_data[end_point.x][end_point.y] = GameConst.NodeTypeEnum.DESTINATION
	
	return {
		"start_point": start_point,
		"end_point": end_point
	}

# 随机类型
func random_node_type():
	var r = randf()
	# 50% 概率为怪物
	if r >= 0 && r <= 0.5:
		return GameConst.NodeTypeEnum.MONSTER
	# 25% 概率为普通物品
	elif r > 0.5 && r<= 0.75:
		var rr  = randf()
		if rr <= 0.4:
			return GameConst.NodeTypeEnum.FIRE_TREE
		var normal_list = [GameConst.NodeTypeEnum.BUSINESS_MAN, GameConst.NodeTypeEnum.SCHOLAR, GameConst.NodeTypeEnum.ASCETIC_MONK, GameConst.NodeTypeEnum.TREASURE]
		var index = randi_range(0, normal_list.size())
		return normal_list[index]
	# 8% 概率为稀有物品
	elif r > 0.75 && r<= 0.83:
		var rare_list = [GameConst.NodeTypeEnum.WATCH_TOWER, GameConst.NodeTypeEnum.OBELISK, GameConst.NodeTypeEnum.TEMPLE, GameConst.NodeTypeEnum.WITCH_HUT]
		var index = randi_range(0, rare_list.size())
		return rare_list[index]
	# 17% 概率为空
	else:
		return GameConst.NodeTypeEnum.EMPTY

# 随机怪物等级
func random_monster_level():
	var level_range = monster_level_range[Global.level]
	return randi_range(level_range[0], level_range[1]+1)
	
# 生成节点的类型
func create_node_role(x: int, y: int):
	var node = map_node_data[x][y]
	if node == GameConst.NodeTypeEnum.EMPTY:
		var type = random_node_type()
		map_node_data[x][y] = type
	
# 实例化地图节点
func instanc_node(x: int, y: int):
	var node = map_node_data[x][y]
	var instance = scene_map[node].instance()
	instance.node_pos = Vector2(x, y)
	var pos = node_to_position(instance.node_pos)
	instance.position = pos
	if node ==  GameConst.NodeTypeEnum.MONSTER:
		instance.level = random_monster_level()
		
	map_node_data[x][y] = instance
	$Viewport.add_child(instance)
	
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
#			var node = MapNode.new(x, y, MapNode.NodeTypeEnum.EMPTY)
			map_node_data[x].append(GameConst.NodeTypeEnum.EMPTY)	
	
	# 生成起点和终点
	var start_and_end = create_start_and_end()
	
	# 生成随机的地图节点
	for x in map_size.x:
		for y in map_size.y:
			create_node_role(x, y)
	
	# 实例化场景节点
	for x in map_size.x:
		for y in map_size.y:
			instanc_node(x, y)
	
	# 生成节点间的连接关系
	for x in map_size.x:
		for y in map_size.y:
			calc_node_connection(x, y)
	
	
	# 生成路径
	for x in map_size.x:
		for y in map_size.y:
			create_road(x, y)

	# 渲染路径和节点
#	for x in range(map_with_road_size.x):
#		for y in range(map_with_road_size.y):
#			tile_map.set_cell(x, y, map_data[x][y])
	
	
	var start = start_and_end["start_point"];
	
	player_to_cell(start)
	update_visible_state(start, visible_area)

func player_to_cell(node_pos): 
	var pos = node_to_position(node_pos)
	player.node_pos = node_pos
	player.position = pos

func player_move(path: Array, target: Vector2):
	var real_pos_path = []
	for p in path:
		real_pos_path.append(node_to_position(p))
	player.move_with_path(real_pos_path, target)
	
func new_game():
	create_map()


func end_game():
	# 销毁地图节点
	$Viewport.get_tree().call_group("map_node", "queue_free")
	

# 更新当前节点周围2格的视野
func update_visible_state(pos: Vector2, n: int):
	
	if(n<=0):
		return
	var around_pos = get_around_point(pos.x, pos.y)
	
	var road_pos_list = []
	
	for p in around_pos:
		road_pos_list.append(p+pos)
		var node = map_node_data[p .x][p .y]
		node.set_visible(true)
		update_visible_state(node.node_pos, n-1)
	
	
	# 获取当前点周围所有的道路坐标
	for p in around_pos:
		for q in around_pos:
			if p != q && !road_pos_list.has(p + q):
				road_pos_list.append(p + q)
				
	for p in road_pos_list:
		tile_map.set_cell(p.x, p.y, map_data[p.x][p.y])
	
	
	
	
# 获取当前点到目标点的路径
func get_access_path(start, target):
	var visitied = []
	var queue = []
	
	# 查找的路径上某个点的上一个节点
	var from = {}
	from[start] = null
	from[target] = null
	visitied.append(start)
	queue.append(start)
	
	while queue.size() > 0:
		var node = queue.pop_front()
		
		var current_node = map_node_data[node.x][node.y]
		
		# 如果找到了
		if node == target:
			break
			
		for next in current_node.next_node_list:
			if !visitied.has(next) && map_node_data[next.x][next.y].node_visible:
				visitied.append(next)
				queue.append(next)
				from[next] = node
#	
	var path = []
	var p_node = target
	while from[p_node] != null:
		path.push_front(p_node)
		p_node = from[p_node]
	
	path.push_front(start)
	return path

# 点击地图上的点
func _on_TileMap_click_cell(pos):
	if pos.x as int % 2 == 0 && pos.y as int % 2 == 0:
		var target = cell_to_node(pos)
		if target.x >= 0 && target.x < map_size.x && target.y >= 0 && target.y < map_size.y:
			var node = map_node_data[target.x][target.y]
			if node.node_visible:
				selected_node = target
				emit_signal('node_selected', node)
				$Viewport/Selected.position = node_to_position(target)

func _on_Player_move_end(target: Vector2):
	update_visible_state(target, visible_area)


func _on_Panel_move():
	var current = player.node_pos
	if selected_node == current:
		return
	
	print(current, selected_node)
	var path = get_access_path(current, selected_node)
	print(path)
	if path.size() < 1:
		return
	
	if !player.is_moving:
		player.node_pos = selected_node
		player_move(path, selected_node)
