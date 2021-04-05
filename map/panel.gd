extends MarginContainer

signal move
signal rest

func _ready():
	$VBoxContainer/TopInfo/TorchCount.text = String(Global.torch)
	$VBoxContainer/TopInfo/CoinCount.text = String(Global.coin)
	Global.connect("torch_change", self, "_on_Torch_change")
	Global.connect("coin_change", self, "_on_Coin_change")


func set_info(name, desc):
	$Info/Name.text = name
	$Info/Desc.text = desc
	
func _on_Go_pressed():
	emit_signal('move')

func _on_Rest_pressed():
	emit_signal('rest')


func _on_MapArea_node_selected(node):
	$VBoxContainer/Info/Name.text = node.node_name
	$VBoxContainer/Info/Desc.text = node.node_desc

func _on_Torch_change(count: int):
	$VBoxContainer/TopInfo/TorchCount.text = String(count)
	
func _on_Coin_change(count: int):
	$VBoxContainer/TopInfo/CoinCount.text = String(count)
	
	
	
