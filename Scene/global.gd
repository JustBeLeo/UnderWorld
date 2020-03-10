extends Node
class_name Global

# 点击弹窗信号
signal press_pop_confirm
signal press_pop_cancel

# 点击车厢信号
signal press_metro_head

# 基建页面物品点击信号
signal press_build_buy_head_item
signal press_build_buy_body_item

# 点击抽奖信号
signal press_lottery_box

# 更新车厢数据
signal update_metros 
var metro_list = []
var passedID = 0	

# 用户数据相关
var user

func _ready():
	metro_list.append([0,'res://Scene/Build/Asserts/metro_head_pink.png'])
	metro_list.append([1,'res://Scene/Build/Asserts/metro_body_pink.png'])
	metro_list.append([2,'res://Scene/Build/Asserts/metro_body_yellow.png'])

func initUserData(userID):
	# 使用接口调用用户信息
	# 获取用户id等相关信息
	# 解析为list
	# 示例数据 [id,app_user_id,nickname,avatar_url,last_time_login,resource_id,train_id]
	user = [0,1,'两个男人','res://Asserts/Images/head2.png','2020-03-02',12,23]
	return user

func update_metros():
	var type := 'update'
	global.emit_signal("update_metros",type)
