extends Control

var icon_already_have = load("res://Scene/Build/Asserts/icon_already_have.png")
var icon_already_have_fill = load("res://Scene/Build/Asserts/icon_already_have_fill.png")
var icon_metro_body = load("res://Scene/Build/Asserts/icon_metro_body.png")
var icon_metro_body_fill = load("res://Scene/Build/Asserts/icon_metro_body_fill.png")
var icon_metro_head = load("res://Scene/Build/Asserts/icon_metro_head.png")
var icon_metro_head_fill = load("res://Scene/Build/Asserts/icon_metro_head_fill.png")
var icon_not_have = load("res://Scene/Build/Asserts/icon_not_have.png")
var icon_not_have_fill = load("res://Scene/Build/Asserts/icon_not_have_fill.png")

# 判断当前状态，1,1是 车头，已拥有 2,2是车厢，未拥有
var page = Vector2(1,1)

func _ready():
	_load_item(page)
	$metroSC.scene = 'build'
	$metroSC.scroll_horizontal += global.passedID*1000
	$pop.visible = false
	global.connect("press_build_buy_head_item", self, "on_press_build_buy_head_item")
	global.connect("press_pop_confirm", self, "on_press_pop_confirm")
	global.connect("press_pop_cancel", self, "on_press_pop_cancel")

# 当点击车头按钮时，车厢按钮暗下，车头亮起
func _on_metro_head_pressed():
	$panel_bottom/switchBar/metro_body/img.texture = icon_metro_body
	$panel_bottom/switchBar/metro_head/img.texture = icon_metro_head_fill
	page.x = 1
	
func _on_metro_body_pressed():
	$panel_bottom/switchBar/metro_body/img.texture = icon_metro_body_fill
	$panel_bottom/switchBar/metro_head/img.texture = icon_metro_head
	page.x = 2

func _on_alreadyHave_pressed():
	$panel_bottom/switchBar2/alreadyHave/TextureRect.texture = icon_already_have_fill
	$panel_bottom/switchBar2/NotHave/TextureRect.texture = icon_not_have
	page.y = 1
	
func _on_NotHave_pressed():
	$panel_bottom/switchBar2/alreadyHave/TextureRect.texture = icon_already_have
	$panel_bottom/switchBar2/NotHave/TextureRect.texture = icon_not_have_fill
	page.y = 2

# 初始化数据结构 0id，1name，2描述，3价格类型（0金币，1钻石），4价格，5图标资源
var metro_head1 = [0,'车头1','上古神车',0,1000,'res://Scene/Build/Asserts/metro_head_pink.png']
var metro_head2 = [1,'车头2','asd车',0,200,'res://Scene/Build/Asserts/metro_head_yellow.png']
var metro_head3 = [2,'车头3','按时车',0,500,'res://Scene/Build/Asserts/metro_body_yellow.png']
var metro_head4 = [3,'车头4','阿斯弗车',0,440,'res://Scene/Build/Asserts/metro_body_pink.png']
var metro_head5 = [4,'车头5','光和热车',0,481,'res://png/011-ticket-office.png']
var metro_head6 = [5,'车头6','阿哥车',0,123,'res://png/012-ship.png']
var metro_head7 = [6,'车头7','死亡战车',0,542,'res://png/013-trolleybus.png']
var metro_head8 = [7,'车头8','终极车',0,458,'res://png/014-double-decker.png']
var metro_heads = [metro_head1,metro_head2,metro_head3,metro_head4,metro_head5,metro_head6,metro_head7,metro_head8]

var itemTSCN = preload("res://Scene/Build/item.tscn")

func _load_item(page):
	var i = 0
	for metro_head in metro_heads:
		var item = itemTSCN.instance()
		# 加载材质
		var texture = load(metro_head[5])
		# 材质需要自行缩放
		item.get_node("img").texture = texture
		item.get_node(".").rect_scale = Vector2(0.2,0.2)
		item.get_node("Label").text = str(metro_head[4])
		item.id = i
		$SC/GC.add_child(item)
		i += 1

# 返回主页面
func _on_back_pressed():
	get_tree().change_scene("res://Scene/MainPage/MainPage.tscn")
	
# 初始化数据结构 0id，1name，2描述，3价格类型（0金币，1钻石），4价格，5图标资源	
func on_press_build_buy_head_item(index):
	$pop/name.text = metro_heads[index][1]
	$pop/desc.text = metro_heads[index][2]
	$pop/confirm/Label.text = str(metro_heads[index][4])
	$pop/item.texture = load(metro_heads[index][5])
	$pop.visible = true
	self.index = index

var index
var num = 1

func on_press_pop_confirm():
	print('购买了' + metro_heads[index][1] + '，花了' + str(num*metro_heads[index][4]))
	$pop.visible = false
	# 更新数据
	var size = global.metro_list.size()
	global.metro_list.append([size,metro_heads[index][5]])
	global.update_metros()
	
func on_press_pop_cancel():
	$pop.visible = false

# 配置滚动
var swiping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []
onready var sc = $SC

func _on_SC_gui_input(ev):
	if ev is InputEventMouseButton:
		if ev.pressed:
			swiping = true
			swipe_start = Vector2(sc.get_h_scroll(), sc.get_v_scroll())
			swipe_mouse_start = ev.position
			swipe_mouse_times = [OS.get_ticks_msec()]
			swipe_mouse_positions = [swipe_mouse_start]
		else:
			swipe_mouse_times.append(OS.get_ticks_msec())
			swipe_mouse_positions.append(ev.position)
			var source = Vector2(sc.get_h_scroll(), sc.get_v_scroll())
			var idx = swipe_mouse_times.size() - 1
			var now = OS.get_ticks_msec()
			var cutoff = now - 100
			for i in range(swipe_mouse_times.size() - 1, -1, -1):
				if swipe_mouse_times[i] >= cutoff: idx = i
				else: break
			var flick_start = swipe_mouse_positions[idx]
			var flick_dur = min(0.3, (ev.position - flick_start).length() / 1000)
			if flick_dur > 0.0:
				var tween = Tween.new()
				sc.add_child(tween)
				var delta = ev.position - flick_start
				tween.interpolate_callback(tween, flick_dur, 'queue_free')
				tween.start()
			swiping = false
	elif swiping and ev is InputEventMouseMotion:
		var delta = ev.position - swipe_mouse_start
		sc.set_h_scroll(swipe_start.x - delta.x)
		sc.set_v_scroll(swipe_start.y - delta.y)
		swipe_mouse_times.append(OS.get_ticks_msec())
		swipe_mouse_positions.append(ev.position)

var offset = Vector2(5,10)
var fullOffset = Vector2(0,0)
var flag = Vector2(1,1)
