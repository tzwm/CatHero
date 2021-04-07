extends Node
class_name MonsterModel

signal fight_end

export(String) var nickname
export(Texture) var avatar
export(int) var level
export(int) var health_max
export(int) var attack
export(int) var coin_dropped
#export(int) var skill

onready var health_current = health_max
