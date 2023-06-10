extends Node3D

@export var player: CharacterBody3D

@onready var body = %RigidBody

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		print ("set oar")
		rotation_degrees = Vector3.ZERO
		body.rotation_degrees = Vector3.ZERO

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		print ("touching")
		player.object_touching = self

func body_rotation():
	print ("BODY IS "+str(body.rotation_degrees))

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		print ("NOT touching")
		player.object_touching = null
		

#func holding(type):
#	body.mode = RigidBody3D.MODE_KINEMATIC

func freeze_me(state):
	%RigidBody.freeze = state
	rotation_degrees =Vector3.ZERO
	%RigidBody.rotation_degrees =Vector3.ZERO
	$RigidBody/Oar.rotation_degrees = Vector3.ZERO
