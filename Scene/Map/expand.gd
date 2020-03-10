extends TextureButton

onready var add_scale  = get_node("../../createStation").get_scale()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_expand_pressed():
	var change_scale = get_node("..").scale()
	add_scale = 1.1 * change_scale
	get_node("../../createStation").set_scale(add_scale)