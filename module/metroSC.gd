extends ScrollContainer

onready var sc = $"."
# 地铁信息，车厢id-车厢资源文件
var metro_list
var METRO = preload("res://module/metro.tscn")
var scene

func _ready():
	global.connect("press_metro_head",self,"on_press_metro_head")
	global.connect("update_metros",self,"_load_metro")
	_load_metro('init')

# 加载地铁数据
func _load_metro(type):
	metro_list = global.metro_list
	if type == 'init':
		for metro in metro_list:	
			# 加载图片资源
			var metroSrc = load(metro[1])
			# 创建一个head
			var metroObject = METRO.instance()
			metroObject.id = metro[0]
			metroObject.texture_normal = metroSrc
			$metroHBC.add_child(metroObject)
	elif type == 'update':
		# 如果是更新则获取最远的一个加载
		var metro = metro_list[metro_list.size()-1]
		var metroSrc = load(metro[1])
		# 创建一个head
		var metroObject = METRO.instance()
		metroObject.id = metro[0]
		metroObject.texture_normal = metroSrc
		$metroHBC.add_child(metroObject)
	print('更新完毕')

func on_press_metro_head(id):
	global.passedID = id
	print(id)
	if(scene=='main'):
		get_tree().change_scene("res://Scene/Build/BuildPage.tscn")
	

# 控制滑动
var swiping = false
var swipe_start
var swipe_mouse_start
var swipe_mouse_times = []
var swipe_mouse_positions = []

func _input(ev):
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

func _physics_process(delta):
	# 调节车厢震动
	$".".rect_position += Vector2(offset.x*delta*flag.x,offset.y*delta*flag.y)
	fullOffset.y += offset.y*flag.y
	if abs(fullOffset.y) >= 150:
		flag.y*=-1
	fullOffset.x += offset.x*flag.x
	if abs(fullOffset.x) >= 300:
		flag.x*=-1
