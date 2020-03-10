extends TextureButton

var id = 0

func _on_item_pressed():
	global.emit_signal("press_build_buy_head_item",id)
