extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_die_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("_scene_restart")
		

func _scene_restart():
	get_tree().reload_current_scene()
