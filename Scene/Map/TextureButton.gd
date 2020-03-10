extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button_pressed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	if(button_pressed):
		get_node("../../../").rect_global_position = Vector2(0,480)
		button_pressed = false
	else:
		get_node("../../../").rect_global_position = Vector2(0,630)
		button_pressed = true