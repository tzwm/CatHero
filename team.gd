extends Control
class_name Team

func _ready():
	Global.Team = self

# 按百分比修改全体英雄血量
# 比如，增加20%，change_all_hero_health(0.2)
# 减少20%，change_all_hero_health(-0.2)
func change_all_hero_health(percent: float):
	for hero in Global.heros:
		hero.change_health(percent)
	
# 复活所有死亡英雄，这些英雄获得血量，并有3张手牌
func revive_all_hero_with_health(percent: float):
	print('revive_all_hero_with_health', percent)
	pass
	
# 所有英雄抽满卡牌
func fill_all_hero_cards():
	for hero in Global.heros:
		for i in range(3):
			hero.draw_a_card()

# 给一张卡牌，英雄随机
func give_one_card():
	Global.heros[randi() % Global.heros.size()].draw_a_card()
	
# 移除一张卡牌
func take_one_card():
	print('take_one_card')
	pass

# 给随机一个英雄添加压抑值，正数为增加，负数为减少
func change_depress(value: int):
	print('change_depress')
	pass

# 修改所有英雄的压抑值，正数为增加，负数为减少
func change_all_hero_depress(value: int):
	print('change_all_hero_depress')
	pass
	
func every_heros_draw_a_card():
	for hero in Global.heros:
		hero.draw_a_card()
