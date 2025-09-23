extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1"):
		$Collected_Sound.playing = true
		await get_tree().create_timer(0.1).timeout
		#await($Collected_Sound)
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player1", "player2")
		GlobalSignal.key_icon.emit()
		print("Key",body)
		queue_free()
	if body.is_in_group("player2"):
		$Collected_Sound.playing = true
		await get_tree().create_timer(0.1).timeout
		#await($Collected_Sound)
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player2", "player1")
		GlobalSignal.key_icon.emit()
		print("Key",body)
		queue_free()
