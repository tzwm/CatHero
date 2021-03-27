extends Area2D

signal move_end

# 节点位置
var node_pos = Vector2(0,0)
# 是否在移动中
var is_moving = false

const speed = 200

var velocity = Vector2(0,0)

var move_path = []

var prev_pos = Vector2(0,0)

var target_pos = Vector2(0,0)

var target_node_pos = Vector2(0,0)

func move_with_path(path: Array, target_node: Vector2):
	if path.size() < 2:
		return 
	
	is_moving = true
	move_path = path.duplicate()
	prev_pos = move_path.pop_front()
	target_pos = move_path.pop_front()
	target_node_pos = target_node
	velocity = (target_pos - prev_pos).normalized()
	
func _process(delta):
	if is_moving:
		if position.x != target_pos.x || position.y != target_pos.y:
			position += velocity * delta * speed
			position.x = clamp(position.x, min(prev_pos.x, target_pos.x), max(prev_pos.x, target_pos.x))
			position.y = clamp(position.y, min(prev_pos.y, target_pos.y), max(prev_pos.y, target_pos.y))
		elif move_path.size() > 0:
			prev_pos = target_pos
			target_pos = move_path.pop_front()
			velocity = (target_pos - prev_pos).normalized()
		else: 
			emit_signal('move_end', target_node_pos)
			is_moving = false
			velocity = Vector2(0, 0)
			prev_pos = Vector2(0,0)
			target_pos = Vector2(0,0)
			move_path.clear()
