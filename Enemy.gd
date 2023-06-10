extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var hud: Control


var speed: float = 2.0

var my_target: Vector3

func update_target_location(target_location):
	nav_agent.target_position = target_location
	my_target = target_location

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	var send_distance = snapped(current_location.distance_to(my_target),0.1)
	hud.update_distance(send_distance)
	velocity = new_velocity
	move_and_slide()
