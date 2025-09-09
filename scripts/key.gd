extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1"):
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player1", "player2")
		print("Key",body)
		queue_free()
	if body.is_in_group("player2"):
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player2", "player1")
		print("Key",body)
		queue_free()
