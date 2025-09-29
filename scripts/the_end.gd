extends Control


func _ready() -> void:
	$Timer.start()

func _camera_shake():
	$Timer.start()
	var camera = get_viewport().get_camera_2d()
	if camera and camera.has_method("shake"):
		camera.shake()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timer_timeout() -> void:
	_camera_shake()
