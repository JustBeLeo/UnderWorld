tool
extends Node2D
onready var number_label = $gamePieces/Count/Background/Number
onready var bar = $gamePieces/TextureProgress
onready var tween = $Tween

var animated_pieces = 40


func _ready():
	var player_min_pieces = get_node("../createStation/station_point").min_pieces
	bar.set_value(player_min_pieces)
	update_pieces(player_min_pieces)


func _on_station_point_pieces_changed(pieces):
	update_pieces(pieces)
	emit_signal("pieces_changed",pieces)


func update_pieces(new_value):
#	tween.interpolate_property(self, "animated_pieces", animated_pieces, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	if not tween.is_active():
#		tween.start()
#-------------------
	number_label.text = str(new_value)
	bar.set_value(new_value)
#--------------------

#func _process(delta):
#	number_label.text = str(animated_pieces)
#	bar.value = animated_pieces


