extends Area2D

@export var next_level : int

var key_owner
var other_player
var opened = false
var player_count = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DoorAnim.play("idle")
	GlobalSignal.connect("key_owner", _key_owner)
	%Label.text = "Locked"
	%Label.show()
	print("Locked")


func _key_owner(owner, follower):
	key_owner = owner
	other_player = follower
	print(key_owner)



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(str(key_owner)):
		player_count += 1
		print(player_count, key_owner)

		if GlobalVars.key == true:
			opened = true
			%DoorAnim.play("open")
			%Label.text = "Opened"
			%Label.show()
			if player_count == 2:
				$Timer.start()
				GlobalSignal.player_celebrating.emit(key_owner)
				GlobalSignal.player_celebrating.emit(other_player)
	if  body.is_in_group(str(other_player)):
		player_count += 1
		print(player_count, other_player)
		if opened:

			print("player Celebrating")
			#$Timer.start()
		if player_count == 2:
			$Timer.start()
			GlobalSignal.player_celebrating.emit(other_player)
			GlobalSignal.player_celebrating.emit(key_owner)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group(str(key_owner)):
		player_count -= 1
		print(player_count, key_owner)
		
	if  body.is_in_group(str(other_player)):
		player_count -= 1
		print(player_count, other_player)



func _on_timer_timeout() -> void:
	call_deferred("_check_level")

func _check_level():
	if next_level == 2:
		GlobalVars.level1_completed = true
		GlobalVars.level2_unlocked = true
		print("Level2 " + str(GlobalVars.level2_unlocked))
		call_deferred("_change_scene")
		
	elif next_level == 3:
		GlobalVars.level2_completed = true
		GlobalVars.level3_unlocked = true
		print("Level3 " + str(GlobalVars.level3_unlocked))
		call_deferred("_change_scene")
		
	elif next_level == 4:
		GlobalVars.level3_completed = true
		GlobalVars.level4_unlocked = true
		print("Level4 " + str(GlobalVars.level4_unlocked))
		call_deferred("_change_scene")
		
	elif next_level == 5:
		GlobalVars.level4_completed = true
		GlobalVars.level5_unlocked = true
		print("Level5 " + str(GlobalVars.level5_unlocked))
		call_deferred("_change_scene")
		
	elif next_level == 6:
		print("level5_completed")
		GlobalVars.level5_completed = true
		print("The end")
		get_tree().change_scene_to_file("res://scenes/the_end.tscn")
		#GlobalVars.level5_unlocked = true
		#print("Level5 " + str(GlobalVars.level5_unlocked))
		#call_deferred("_change_scene")
	

func _change_scene():
	if next_level == 2:
		get_tree().change_scene_to_file("res://scenes/Oops_a_trap.tscn")
		
	elif next_level == 3:
		get_tree().change_scene_to_file("res://scenes/Mind_the_Gap.tscn")
		
	elif next_level == 4:
		get_tree().change_scene_to_file("res://scenes/Almost_Made_It.tscn")
		
	elif next_level == 5:
		get_tree().change_scene_to_file("res://scenes/One_Step_Away.tscn")
		
	#elif  next_level == 6:
		#get_tree().change_scene_to_file("res://scenes/the_end.tscn")
