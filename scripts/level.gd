extends Node2D


func _ready() -> void:
	pass
	#GlobalSignal.key_icon.emit(false)
	
	
	#GlobalSignal.connect("level_complete", _level_completed)
#
#



#func _level_completed(level):
	#if level == 1:
		#print("level 1 completed")
		## You can store this in GlobalVars instead
		#GlobalVars.level1_completed = true


func _on_death_area_body_entered(body: Node2D) -> void:
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
