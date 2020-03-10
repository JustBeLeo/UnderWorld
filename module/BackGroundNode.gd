extends Node2D

var width = 0

func _ready():
	# 获取背景宽度用于无限滚动背景
	width = $Background1.texture.get_width()

func _physics_process(delta):
	# 无限滚动背景
	$Background1.translate(Vector2(300*delta,0))
	$Background2.translate(Vector2(300*delta,0))
	if $Background1.position.x >= width:
		$Background1.position.x = -width+20
	if $Background2.position.x >= width:
		$Background2.position.x = -width+20


