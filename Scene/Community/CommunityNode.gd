extends Control

# 控制顶部三个页面切换的Index
var current_index = 1

var style_unselected = StyleBoxFlat.new()
var style_selected = StyleBoxFlat.new()
var tColor1 = Color('226bb3')
var tColor2 = Color('f1f8fd')

var friend = preload("res://Scene/Community/friendNode.tscn")

func _ready():
	style_unselected.set_bg_color(Color('226bb3'))
	style_selected.set_bg_color(Color('f1f8fd'))
	style_unselected.set_corner_radius_individual(30,30,0,0)
	style_selected.set_corner_radius_individual(30,30,0,0) 
	for i in range(20):
		var f = friend.instance()
		$SC/VC.add_child(f)

func _changeStyle(var index):
	current_index = index
	if index == 0:
		$TabBar/addFriend.add_stylebox_override("panel",style_selected)
		$TabBar/addFriend/Label.add_color_override("font_color",tColor1)
		
		$TabBar/friendList.add_stylebox_override("panel",style_unselected)
		$TabBar/friendList/Label.add_color_override("font_color",tColor2)
		
		$TabBar/organize.add_stylebox_override("panel",style_unselected)
		$TabBar/organize/Label.add_color_override("font_color",tColor2)
	if index == 1:
		$TabBar/addFriend.add_stylebox_override("panel",style_unselected)
		$TabBar/addFriend/Label.add_color_override("font_color",tColor2)
		
		$TabBar/friendList.add_stylebox_override("panel",style_selected)
		$TabBar/friendList/Label.add_color_override("font_color",tColor1)
		
		$TabBar/organize.add_stylebox_override("panel",style_unselected)
		$TabBar/organize/Label.add_color_override("font_color",tColor2)
		
	if index == 2:
		$TabBar/addFriend.add_stylebox_override("panel",style_unselected)
		$TabBar/addFriend/Label.add_color_override("font_color",tColor2)
		
		$TabBar/friendList.add_stylebox_override("panel",style_unselected)
		$TabBar/friendList/Label.add_color_override("font_color",tColor2)
		
		$TabBar/organize.add_stylebox_override("panel",style_selected)
		$TabBar/organize/Label.add_color_override("font_color",tColor1)

func _on_addFriend_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 0:
			_changeStyle(0)

func _on_friendList_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 1:
			_changeStyle(1)

func _on_organize_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 2:
			_changeStyle(2)

func _on_back_pressed():
	get_tree().change_scene("res://Scene/MainPage/MainPage.tscn")
