tool
extends Node2D

export var editor_process: = true setget set_editor_process

export var line_color: = Color(0.228943, 0.710254, 0.945312)
export var line_width: = 10.0
export var triangle_color: = Color(0.722656, 0.908997, 1)
var _active_point_index: = 0
# 实例化
var scn = ResourceLoader.load("res://Scene/Map/MovingPlatform.tscn")
var moving_platform = scn.instance()
	
func _ready() -> void:
	if not Engine.editor_hint:
		set_process(false)

func _process(delta: float) -> void:
	update()

func _draw() -> void:
	#if not Engine.editor_hint:
	#	return
	if not get_child_count() > 1:
		return
	var points: = PoolVector2Array()
	# var triangles: = []
	var last_point: = Vector2.ZERO
	# 最后的点
	for child in get_children():
		points.append(child.position)
		if points.size() > 1:
			var center: Vector2 = (child.position + last_point) / 2
			var angle: = last_point.angle_to_point(child.position)
			# 放在线上的箭头
			# triangles.append({center=center, angle=angle})
		last_point = child.position
	points.append(get_child(0).position)
	
	draw_polyline(points, line_color, line_width, true)
	# 画蓝色的线
#	for triangle in triangles:
		# draw_triangle(triangle['center'], triangle['angle'], line_width * 2.0)


func get_start_position(index: int) -> Vector2:
	print("开始站点的索引为：",index)
	_active_point_index = index
	return get_child(index).global_position


func get_current_point_position(index_end: int) -> Vector2:
	if _active_point_index == index_end:
		_active_point_index = index_end-1
	print("当前站点的索引为：",_active_point_index )
	return get_child(_active_point_index).global_position


func get_next_point_position():
	var index_end = moving_platform.set_station(moving_platform.end_station)
	if _active_point_index < index_end:
		print("下一站站点的索引为：",_active_point_index )
		_active_point_index = (_active_point_index + 1)
		return get_current_point_position(index_end)
	else:
		set_physics_process(false)
"""
	var change_flag 
	if _active_point_index < index_end:
		# 判断是否到达终点站
		var station_string = moving_platform.index_to_string(_active_point_index)
		change_flag = moving_platform.ischange(station_string)
		if change_flag == 9999:
			# 不换乘
			print("下一站站点的索引为：",_active_point_index )
			_active_point_index = (_active_point_index + 1)
		else:
			_active_point_index = change_flag
		return get_current_point_position(index_end)
	else:
		set_physics_process(false)
"""

func draw_triangle(center:Vector2, angle:float, radius:float) -> void:
	var points: = PoolVector2Array()
	var colors: = PoolColorArray([triangle_color])
	for i in range(3):
		var angle_point: = angle + i * 2.0 * PI / 3.0 + PI
		var offset: = Vector2(radius * cos(angle_point), radius * sin(angle_point))
		var point: = center + offset
		points.append(point)
	draw_polygon(points, colors)


func set_editor_process(value:bool) -> void:
	editor_process = value
	if not Engine.editor_hint:
		return
	set_process(value)
