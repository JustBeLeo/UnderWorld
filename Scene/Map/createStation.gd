tool
extends Node2D

export var line_color1: = Color(0.228943, 0.710254, 0.945312,1)
export var line_color2: = Color(1, 0, 0,1)
export var line_width: = 2
var station: Array = [["堰桥", "锡北运河", "西漳", "天一", "刘潭", "庄前", "民丰", "无锡火车站", "胜利门", "三阳广场", "南禅寺", "谈渡桥", "太湖广场", "清名桥", "人民医院", "华清大桥", "扬名", "南湖家园", "塘铁桥", "金匮公园", "市民中心", "文化宫", "江南大学", "长广溪", "雪浪", "葛埭桥", "南方泉"],["梅园开原寺", "荣巷", "小桃源", "河埒口", "大王基", "梁溪大桥", "五爱广场", "三阳广场", "东林广场", "上马墩", "靖海", "广益", "柏庄", "东亭", "庄桥", "云林", "九里河公园", "查桥", "映月湖公园", "迎宾广场", "无锡东站"]]
var position_station: Array = [[Vector2(0, 0), Vector2(0.2, 85.5), Vector2(62.700001, 194.449997), Vector2(58.150002, 246.574997), Vector2(58.650002, 317.787506), Vector2(55.200001, 428.5), Vector2(62.950001, 487.087494), Vector2(45.150002, 562.325012), Vector2(82.75, 608.349976), Vector2(83.800003, 647.049988), Vector2(49.450001, 703.112488), Vector2(54.049999, 739.412476), Vector2(53.549999, 783.962524), Vector2(18.75, 823.012512), Vector2(-24.450001, 869.112488), Vector2(-71.900002, 920.262512), Vector2(-54.099998, 1002.587524), Vector2(-51.549999, 1078.012451), Vector2(-61.25, 1136.5625), Vector2(-29.9, 1184.175049), Vector2(51.650002, 1200.237549), Vector2(131.949997, 1207.199951), Vector2(201.949997, 1245.087524), Vector2(209, 1314.275024), Vector2(196.449997, 1401.625), Vector2(225.800003, 1480.824951), Vector2(250, 1550.324951)],
		[Vector2(354.733337, 538.450012), Vector2(290.666656, 513.333313), Vector2(242.46666, 502.399994), Vector2(201.066666, 490.299988), Vector2(146.199997, 479.858337), Vector2(106.5, 470.274994), Vector2(90.599998, 443.108337), Vector2(53.366665, 432.658325), Vector2(24.200001, 421.558319), Vector2(-22.733334, 402.958344), Vector2(-55.5, 399.225006), Vector2(-97.73333, 384.241669), Vector2(-133.766663, 386.183319), Vector2(-180.566666, 402.658325), Vector2(-237.733337, 420.658325), Vector2(-297.133331, 415.75), Vector2(-348.866669, 412.799988), Vector2(-432.066681, 409.891663), Vector2(-500.666656, 382.325012), Vector2(-517.866638, 362.458344), Vector2(-538.666687, 339.141663)]]
var change_station: Array = ["三阳广场"]
var s
var dynamic_font = DynamicFont.new()
var station_point= preload("res://Scene/Map/station_point.tscn")


func _ready():
	create_station()
	
#func _process(delta):
#	update()
	
func create_station():
	var i : int = 0
	var j : int = 0 
	var k : int = 0
	for i in range(0,2):
		var length_line = len(station[i])
		for j in range(0,length_line):
			var station_point_instance = station_point.instance()
			if station[i][j] in change_station:
				if !get_node(station[i][j]):
					j+=1
			else:
				station_point_instance.name = station[i][j]
				station_point_instance.set_position(position_station[i][j])
				dynamic_font.font_data = load("res://Asserts/ttf/HYHanHeiW.ttf")
				dynamic_font.size = 20
				if i==1:
#					if j == 6:
#						station_point_instance.get_child(3).text = station[i][j]
#						station_point_instance.get_child(3).set("custom_fonts/font", dynamic_font)
#					else:
					station_point_instance.get_child(1).text = station[i][j]
					station_point_instance.get_child(1).set("custom_fonts/font", dynamic_font)
#					if j == randi()%7:
					if j == 10:
						station_point_instance.get_child(0).set_visible(false)
						station_point_instance.get_child(3).set_visible(true)
					if j == 9:
						station_point_instance.get_node("point").set_visible(true)
				else:
					station_point_instance.get_child(2).text = station[i][j]
					station_point_instance.get_child(2).set("custom_fonts/font", dynamic_font)
				add_child(station_point_instance)
#				对线分组
				station_point_instance.add_to_group(str(i+1)+"号线")
#	print(get_tree().get_nodes_in_group("1号线"))
#	print(get_tree().get_nodes_in_group("2号线"))				
	
	
		
		
func _draw() -> void:
	for i in range(0,2):
		if i == 1:
			draw_polyline(PoolVector2Array(position_station[i]), line_color1, line_width, true)	
		else:
			draw_polyline(PoolVector2Array(position_station[i]), line_color2, line_width, true)	
			

func set_alpha(choose_line):
	var station 
	if choose_line == "all":
#		line_color1 = Color(0.228943, 0.710254, 0.945312,1)
#		line_color2 = Color(1, 0, 0,1)
		for station in get_tree().get_nodes_in_group("1号线"):
			station.set_modulate(Color(1,1,1,1))
		for station in get_tree().get_nodes_in_group("2号线"):
			station.set_modulate(Color(1,1,1,1))
	elif choose_line == "1号线":
		for station in get_tree().get_nodes_in_group("1号线"):
			station.set_modulate(Color(1,1,1,1))
		for station in get_tree().get_nodes_in_group("2号线"):
			station.set_modulate(Color(1,1,1,0.2))
#		line_color2 = Color(1, 0, 0,0.2)
	else :
		for station in get_tree().get_nodes_in_group("1号线"):
			station.set_modulate(Color(1,1,1,0.2))
		for station in get_tree().get_nodes_in_group("2号线"):
			station.set_modulate(Color(1,1,1,1))
#		line_color1 = Color(0.228943, 0.710254, 0.945312,0.2)
		
