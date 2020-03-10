extends MarginContainer

var button_pressed_drag= true


func _ready():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	if(button_pressed_drag):
		get_node(".").rect_global_position = Vector2(0,1770)
		button_pressed_drag = false
	else:
		get_node(".").rect_global_position = Vector2(0,1800)
		button_pressed_drag = true

func _on_allLine_pressed():
#	if(button_pressed_all):
	$"../createStation".set_alpha("all")


func _on_Line1_pressed():
	$"../createStation".set_alpha("1号线")
		

func _on_Line2_pressed():
	$"../createStation".set_alpha("2号线")
