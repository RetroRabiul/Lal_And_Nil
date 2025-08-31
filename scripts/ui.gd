extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	call_deferred("_change_scene")
	
func _change_scene():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
