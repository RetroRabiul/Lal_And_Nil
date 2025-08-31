extends Node2D

var ui_visible : bool

func _ready() -> void:
	%UI.hide()
	GlobalSignal.connect("ui_state", _ui_state)
	# Add this line to listen for level completion
	GlobalSignal.connect("level_complete", _level_completed)


func _ui_state():
	if ui_visible == false:
		%UI.show()
		ui_visible = true
		print("UI showed")
	elif ui_visible == true:
		%UI.hide()
		ui_visible = false

func _level_completed(level):
	if level == 1:
		print("level 1 completed")
		# You can store this in GlobalVars instead
		GlobalVars.level1_completed = true
