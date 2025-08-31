extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
