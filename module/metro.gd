extends TextureButton

var id
var down
var up

func _on_car_gui_input(event):
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
   elif event is InputEventMouseMotion:
	   print("Mouse Motion at: ", event.position)

func _on_car_button_down():
	down = get_viewport().get_mouse_position()

func _on_car_button_up():
	up = get_viewport().get_mouse_position()
	var distance = (up.x-down.x)*(up.x-down.x) + (up.y-down.y)*(up.y-down.y)
	if(distance<1000):
		global.emit_signal("press_metro_head",id)
