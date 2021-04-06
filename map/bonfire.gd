extends PopupDialog

# 技能编号
var skill = 0

func _on_Panel_rest():
	popup()

func base_func():
	Global.depress_change(-1)
	Global.Team.change_all_hero_health(0.2)

func skill_rest():
	var success = Global.torch_change(-3)
	if success:
		base_func()
		Global.Team.fill_all_hero_cards()
		hide()
	
func skill_default():
	# 扣除火把
	var success = Global.torch_change(-2)
	if success:
		base_func()
		hide()
	else:
		pass


func _on_Go_toggled(button_pressed):
	if button_pressed:
		skill = 0
		$Intro/Label.text = ''

func _on_Rest_toggled(button_pressed):
	if button_pressed:
		skill = 1
		$Intro/Label.text = '额外支付1个火把，所有英雄把卡片抽满'


func _on_Confirm_pressed():
	if skill == 0:
		skill_default()
	elif skill == 1:	
		skill_rest()
