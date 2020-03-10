extends Node2D

var userStation = [Vector2(58.150002, 246.574997), Vector2(58.650002, 317.787506), Vector2(55.200001, 428.5)]
#var target_position: = Vector2(355.950012, 121.012497)
onready var wait_timer: Timer = $Timer
export var speed: = 20
onready var createStation: = get_node("../createStation")
var index :int =5
var index_target: int = index+1
var index_end :int =8
var target_position: = Vector2()
var position_change: = Vector2()
#export var createStation_path: = createStation
# Called when the node enters the scene tree for the first time.
func _ready():
#	change()
	position = createStation.get_child(index).global_position
	target_position = createStation.get_child(index_target).global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta: float):
	var direction: = (target_position - position).normalized()
	var motion: = direction * speed * delta
	var distance_to_target: = position.distance_to(target_position)
	position_change = position
	if motion.length() > distance_to_target:
		position = target_position
		target_position = createStation.get_child(index_target+1).global_position
		set_physics_process(false)
#		wait_timer.start()
	else:
		position += motion
#		if position_change == target_position:
#			position = target_position
#			target_position = createStation.get_child(index_target+1).global_position


#func change():
#	var i = 0
#	for i in range(0,len(userStation)) :
#		$Sprite.position = userStation[i]
#		i += 1