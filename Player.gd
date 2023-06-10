extends CharacterBody3D

var camera: Camera3D
var head: Node3D

var move_speed: float = 5.0
var jump_force: float = 5.0
var gravity: float = 9.0

var look_sens: float = 0.5
var min_x_rotation: float = -85.0
var max_x_rotation: float = 85.0
var mouse_dir: Vector2

var using_mouse: bool = false

var object_touching: Node3D
var carried_item: Node3D
var hand: Node3D

var carrying_object: bool = false

var raycast : RayCast3D
var my_hand: Marker3D
var picked_object
var pull_strength: float = 8

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)
	

func pick_object():
	if raycast == null:
		return	
	var collider = raycast.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_object = collider

func drop_object():
	if picked_object != null:
		picked_object = null

func _input(event):
	if event is InputEventMouseMotion and not using_mouse:
		camera.rotation_degrees.x += event.relative.y * -look_sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rotation, max_x_rotation )
		camera.rotation_degrees.y += event.relative.x * -look_sens
	
	if Input.is_action_just_pressed("pick_object") and not using_mouse:
		if picked_object == null:
			pick_object()
		else:
			drop_object()
#		hand = get_node("/root/Main/Camera3D/Hand")
#		if object_touching != null and event.button_index==1:
##			object_touching.freeze_me(true)
##			object_touching.reparent(hand)
##			object_touching.holding(3)
#			carried_item = object_touching
#			carrying_object = true
#			print ("GRABBED")
#			carrying_object = true
#			hand.get_child(0).holding(true)
#			hand.get_child(0).global_transform.origin = hand.global_transform.origin
#			hand.get_child(0).position = Vector3.ZERO
#			hand.get_child(0).position.y = 1
#			hand.get_child(0).rotation_degrees = Vector3.ZERO
#			print (hand.rotation_degrees)
#			print (hand.get_child(0).rotation_degrees)
#			hand.get_child(0).body_rotation()

			
#		if hand.get_child_count() > 0 and event.button_index==2:
##			object_touching.holding(0)
#			carrying_object = false
#			carried_item = null
##			hand.get_child(0).freeze_me(false)
##			hand.get_child(0).reparent(get_node("/root/Main"))
#			print ("DROPPED")

			
	
func _process(delta):
	camera.position = head.global_position

	

	if Input.is_action_just_pressed("escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
			using_mouse = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			using_mouse = true

func _physics_process(delta):
	
	if using_mouse:
		return
	
	if carrying_object:
		carried_item.global_transform.origin = hand.global_transform.origin
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
	
	var input = Input.get_vector("move_left","move_right","move_forward","move_back")
	
	var dir = camera.basis.z * input.y + camera.basis.x * input.x
	dir.y = 0 
	dir = dir.normalized()
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()
	
	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = my_hand.global_transform.origin
		picked_object.set_linear_velocity((b-a)*pull_strength)


func _on_timer_timeout():
	raycast = get_node("/root/Main/Camera3D/RayCast3D")
	my_hand = get_node("/root/Main/Camera3D/MyHand")
