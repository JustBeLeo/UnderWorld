extends TextureRect

var index
var num	

func _on_confirm_pressed():
	global.emit_signal("press_pop_confirm")


func _on_cancel_pressed():
	global.emit_signal("press_pop_cancel")
