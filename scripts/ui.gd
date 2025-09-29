extends CanvasLayer


var ui_visible : bool

@onready var key = $key_collected


func _ready() -> void:
	key.hide()
	%menu.hide()
	#GlobalSignal.connect("ui_state", _ui_state)
	GlobalSignal.connect("key_icon", _key_icon)
	#if GlobalVars.key:
		#print("key_icon")
		#key.show()

func _input(event):
	
	if Input.is_action_just_pressed("restart"):
		# Trigger camera shake
		var camera = get_viewport().get_camera_2d()
		if camera and camera.has_method("shake"):
			camera.shake()
		get_tree().reload_current_scene()
	
	
	if Input.is_action_just_pressed("show_ui"):
		print("UI")
		
		if ui_visible == false:
			%menu.show()
			ui_visible = true
			print("UI showed")
		elif ui_visible == true:
			%menu.hide()
			ui_visible = false
		
		#
		#if get_tree().paused:
			#print("UI_resume")
			#resume_game()
		#else:
			#print("UI_paused")
			#pause_game()


func pause_game():
	%menu.visible = true
	get_tree().paused = true

func resume_game():
	%menu.visible = false
	get_tree().paused = false



func _key_icon():
	print("key_icon")
	key.show()
		

#func _ui_state():
	#if ui_visible == false:
		#%menu.show()
		#ui_visible = true
		#print("UI showed")
	#elif ui_visible == true:
		#%menu.hide()
		#ui_visible = false



func _on_menu_button_pressed() -> void:
	print("change to menu scene")
	call_deferred("_change_scene")



func _change_scene():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
