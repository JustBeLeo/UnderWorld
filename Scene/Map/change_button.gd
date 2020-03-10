extends Node2D

var change_scale

func _ready():
	scale()

func scale():
	change_scale  = get_node("../createStation").get_scale()
	return change_scale
