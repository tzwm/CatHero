extends MarginContainer

signal move
signal rest

func _ready():
	$VBoxContainer/TopInfo/TorchCount.text = String(Global.torch)
	Global.connect("change_torch", self, "_on_Change_torch")

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

func _on_Change_torch(count: int):
	$VBoxContainer/TopInfo/TorchCount.text = String(count)
	
	
