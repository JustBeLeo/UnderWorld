extends TextureButton

onready var sub_scale  = get_node("../../createStation").get_scale()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_expand2_pressed():
	var change_scale = get_node("..").scale()
	sub_scale = 0.9 * change_scale
	get_node("../../createStation").set_scale(sub_scale)