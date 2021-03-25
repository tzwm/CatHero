extends Node
class_name MonsterModel

export(String) var nickname
export(Texture) var avatar
export(int) var level
export(int) var health_max
export(int) var attack
export(int) var coin_dropped
#export(int) var skill

var health_current

# Called when the node enters the scene tree for the first time.
func _init():
	health_current = health_max


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
