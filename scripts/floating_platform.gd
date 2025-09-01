extends StaticBody2D

@export var move_to = Vector2.ZERO
@export var move_time = 3.0

var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO

var going_up = false
var direction = 1


func _ready():
	#$Timer.wait_time = move_time
	start_pos = global_position
	#GlobalSignal.connect("platform", _movement)



func use_me(state):
	if state:
		_movement("up")
	else:
		_movement("down")


func _movement(action):
	print(action)
	if action == "up" and !going_up:
		going_up = true
		#move_to.y = -200
		_begin_moving()
	elif action == "down" and going_up:
		going_up = false
		#move_to.y = 200
		_begin_moving()


func _begin_moving():
	if direction == 1:
		target_pos = start_pos + move_to
	else:
		target_pos = start_pos
		
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, move_time)

	await (tween)
	direction *= -1
	

func _on_timer_timeout() -> void:
	_begin_moving()
