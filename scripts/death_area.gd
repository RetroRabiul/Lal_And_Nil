extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") or body.is_in_group("player2"):
		#await()
		call_deferred("_level_reset")
		#get_tree().reload_current_scene()

func _level_reset():
	# Trigger camera shake
	var camera = get_viewport().get_camera_2d()
	if camera and camera.has_method("shake"):
		camera.shake()
	get_tree().reload_current_scene()
