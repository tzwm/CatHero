extends Control
class_name Team

func _ready():
	Global.Team = self

# 按百分比修改全体英雄血量
# 比如，增加20%，change_all_hero_health(0.2)
# 减少20%，change_all_hero_health(-0.2)
func change_all_hero_health(percent: float):
	pass

# 所有英雄抽满卡牌
func fill_all_hero_cards():
	pass
