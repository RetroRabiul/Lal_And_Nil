extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") or body.is_in_group("player2"):
		#await()
		call_deferred("_level_reset")
		#get_tree().reload_current_scene()

func _level_reset():
	get_tree().reload_current_scene()
