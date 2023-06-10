extends Node3D


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("door_open")





func _on_area_3d_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("door_close")
