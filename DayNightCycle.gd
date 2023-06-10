extends Node3D

var time: float
@export var day_length: float = 30
@export var start_time: float = 0.3
var time_rate: float

var sun: DirectionalLight3D

func _ready():
	time_rate = 1.0/day_length
	time = start_time
	
	sun = get_node("Sun")


func _process(delta):
	time += time_rate * delta
	if time >= 1:
		time = 0
	
	sun.rotation_degrees.x = time * 360
