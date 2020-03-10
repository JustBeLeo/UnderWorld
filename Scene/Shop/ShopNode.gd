extends Control

# 控制顶部三个页面切换的Index
var current_index = 1

var style_unselected = StyleBoxFlat.new()
var style_selected = StyleBoxFlat.new()
var tColor1 = Color('226bb3')
var tColor2 = Color('f1f8fd')

# 控制单个页面内部滑动特效
var mouseFlag = false	# 鼠标是否点击
var mouseLocation		# 鼠标当前位置
var currentRect			# 面板当前位置
var currentPage = 1		# 当前页码
var allPage = 10		# 全部页码

# 定义商品
# 格式为 id,名字，价格类型（0金币，1钻石），价格，图标资源,描述
var item1 = [0,'偷天圣骑',0,500,"res://png/001-train.png","一个可以摸鱼的道具1"]
var item2 = [1,'魔域力气',0,600,"res://png/002-waiting-room.png","一个可以摸鱼的道具2"]
var item3 = [2,'阿萨发文',0,400,"res://png/003-lorry.png","一个可以摸鱼的道具3"]
var item4 = [3,'死亡之力',0,300,"res://png/004-ambulance.png","一个可以摸鱼的道具4"]
var item5 = [4,'魔域战士',0,200,"res://png/005-no-smoking.png","一个可以摸鱼的道具5"]
var item6 = [5,'摸鱼男人',0,600,"res://png/006-rickshaw.png","一个可以摸鱼的道具6"]
var items = [item1,item2,item3,item4,item5,item6]

# 加载
onready var itemSprite = [$ItemGrid/Item1,$ItemGrid/Item2,$ItemGrid/Item3,$ItemGrid/Item4,$ItemGrid/Item5,$ItemGrid/Item6]
var choosedItem

func _ready():
	# 初始化标签背景颜色
	style_unselected.set_bg_color(Color('226bb3'))
	style_selected.set_bg_color(Color('f1f8fd'))
	style_unselected.set_corner_radius_individual(30,30,0,0)
	style_selected.set_corner_radius_individual(30,30,0,0)
	
	# 设置弹出窗口信息
	$pop.visible = false
	global.connect("press_pop_confirm",self,"_on_confirm_pressed")
	global.connect("press_pop_cancel",self,"_on_cancel_pressed")
	
	# 抽奖初始化
	$Lottery.visible = false
	
	# 加载初始数据
	_load_items(0,0)
	

# 加载商品
func _load_items(type,page):
	# 定位
	var px = itemSprite[0].texture_normal.get_width() / 2
	var py = itemSprite[0].texture_normal.get_height() / 2
	# 加载数据
	for i in range(6):
		var texture = load(items[i][4])
		itemSprite[i].get_node('img').set_texture(texture)
		itemSprite[i].get_node('priceLabel').text = str(items[i][3])

func _changeStyle(var index):
	current_index = index
	if index == 0:
		$TabBar/ItemShop.add_stylebox_override("panel",style_selected)
		$TabBar/ItemShop/Label.add_color_override("font_color",tColor1)
		
		$TabBar/DailySale.add_stylebox_override("panel",style_unselected)
		$TabBar/DailySale/Label.add_color_override("font_color",tColor2)
		
		$TabBar/ChangeShop.add_stylebox_override("panel",style_unselected)
		$TabBar/ChangeShop/Label.add_color_override("font_color",tColor2)
	if index == 1:
		$TabBar/ItemShop.add_stylebox_override("panel",style_unselected)
		$TabBar/ItemShop/Label.add_color_override("font_color",tColor2)
		
		$TabBar/DailySale.add_stylebox_override("panel",style_selected)
		$TabBar/DailySale/Label.add_color_override("font_color",tColor1)
		
		$TabBar/ChangeShop.add_stylebox_override("panel",style_unselected)
		$TabBar/ChangeShop/Label.add_color_override("font_color",tColor2)
		
	if index == 2:
		$TabBar/ItemShop.add_stylebox_override("panel",style_unselected)
		$TabBar/ItemShop/Label.add_color_override("font_color",tColor2)
		
		$TabBar/DailySale.add_stylebox_override("panel",style_unselected)
		$TabBar/DailySale/Label.add_color_override("font_color",tColor2)
		
		$TabBar/ChangeShop.add_stylebox_override("panel",style_selected)
		$TabBar/ChangeShop/Label.add_color_override("font_color",tColor1)

func _on_ItemShop_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 0:
			$ItemGrid.visible = true
			$Lottery.visible = false
			_load_items(0,0)
			_changeStyle(0)

func _on_DailySale_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 1:
			$ItemGrid.visible = true
			$Lottery.visible = false
			_load_items(0,0)
			_changeStyle(1)

func _on_ChangeShop_gui_input(event):
	if event is InputEventMouseButton:
		if current_index != 2:
			$ItemGrid.visible = false
			$Lottery.visible = true
			_changeStyle(2)

func _on_back_pressed():
	get_tree().change_scene("res://Scene/MainPage/MainPage.tscn")

# 格式为 0id，1名字，2价格类型（0金币，1钻石），3价格，4图标资源,5描述
# 点击某个item时
func _on_Item_pressed(index):
	choosedItem = items[index-1]
	var texture = load(choosedItem[4])
	$pop/item.texture = texture
	# $pop/item.rect_scale = Vector2(0.3,0.3)
	$pop/name.text = choosedItem[1]
	$pop/desc.text = choosedItem[5]
	$pop/confirm/Label.text = str(choosedItem[3])
	$pop.visible = true

# 点击面板上的取消按钮
func _on_cancel_pressed():
	$pop.visible = false

# 单击购买按钮
func _on_confirm_pressed():
	# 调用购买接口
	print(choosedItem[3])
	# 刷新全局个人信息
	# 关闭弹窗
	$pop.visible = false
	pass
