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
	if Input.is_action_just_pressed("show_ui"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()


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


func _on_button_pressed() -> void:
	call_deferred("_change_scene")
	
func _change_scene():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
