 tool
extends Node
# 字体属性最好放在全局变量里
var dynamic_font = DynamicFont.new()

var information = preload("res://Scene/Map/information.tscn")
export var min_pieces = 40
var pieces = min_pieces
signal pieces_changed(value)
func _ready():
	pass



func _on__pressed():
	var info = information.instance()
	var current_station = get_name()
	info.get_child(2).text = current_station
	add_child(info)
#

func _on_box_pressed():
	var info_1 = information.instance()
	var current_station = get_name()
	info_1.get_child(2).text = current_station
	info_1.get_node("Label").set_visible(false)
	info_1.get_node("minutes").set_visible(false)
	info_1.get_node("Label3").set_visible(false)
	info_1.get_node("box").set_visible(true)
#	碎片进度＋1
	add_child(info_1)
	take_pieces()
	
func take_pieces():
	pieces += 1
	if pieces >= 100:
		pieces == 100	
	emit_signal("pieces_changed",pieces)
	$"../../gamePieces".update_pieces(pieces)



