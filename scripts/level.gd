extends Node2D


func _ready() -> void:
	# Add this line to listen for level completion
	pass
	#GlobalSignal.connect("level_complete", _level_completed)
#
#
#func _level_completed(level):
	#if level == 1:
		#print("level 1 completed")
		## You can store this in GlobalVars instead
		#GlobalVars.level1_completed = true
