extends Control

func _ready():
	initData()
	$CarSC.scene = 'main'

# 初始化数据
func initData():
	# 通过应用用户id获取用户数据，存入global中
	# 示例数据 [0id,1app_user_id,2nickname,3avatar_url,4last_time_login,5resource_id,6train_id]
	var user = global.initUserData(123)
	$User/name.text = user[2]
	$User/Avatar.texture_normal = load(user[3])
	
func _on_Shop_gui_input(event):
	if event is InputEventMouseButton:
		get_tree().change_scene("res://Scene/Shop/ShopNode.tscn")

func _on_Community_gui_input(event):
	if event is InputEventMouseButton:
		get_tree().change_scene("res://Scene/Community/CommunityNode.tscn")

func _on_Avatar_pressed():
	print('点击头像')
	get_tree().change_scene("res://Scene/personal/MyMainPage.tscn")
