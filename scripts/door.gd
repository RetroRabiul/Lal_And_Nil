extends Area2D

@export var next_level : int

var key_owner
var other_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignal.connect("key_owner", _key_owner)
	%Label.hide()


func _key_owner(owner, follower):
	key_owner = owner
	other_player = follower
	print(key_owner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(str(key_owner)):
		if GlobalVars.key == true:
			%Label.text = "Opened"
			%Label.show()
			
		else:
			%Label.text = "Locked"
			%Label.show()
			print("Locked")
			return
	if body.is_in_group(str(other_player)) and GlobalVars.key == true:
		$Timer.start()

func _on_timer_timeout() -> void:
	call_deferred("_check_level")

func _check_level():
	if next_level == 2:
		GlobalVars.level2_unlocked = true
		GlobalVars.level1_completed = true  # Add this
		GlobalSignal.emit_signal("level_complete", 1)
		print("Level2 " + str(GlobalVars.level2_unlocked))
		call_deferred("_change_scene")

func _change_scene():
	if next_level == 2:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	elif next_level == 3:
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
