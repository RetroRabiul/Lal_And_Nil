extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") or body.is_in_group("player2"):
		$AnimationPlayer.play("pressed")
		GlobalSignal.emit_signal("floor_trap", "close")



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player1") or body.is_in_group("player2"):
		$AnimationPlayer.play("relessed")
		GlobalSignal.emit_signal("floor_trap", "Open")
