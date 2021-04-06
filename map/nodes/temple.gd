extends MapNodeBase

func visit():
	var can = .can_trigger()
	if can:
		$CanvasLayer/Popup.popup()
		.visit()


func _on_Cancel_pressed():
	$CanvasLayer/Popup.hide()


func _on_Confirm_pressed():
	var success = Global.coin_change(-5)
	if success:
		Global.Team.revive_all_hero_with_health(0.5)
		$CanvasLayer/Popup.hide()
