extends StaticBody2D

@export var move_to = Vector2.ZERO
@export var move_time = 3.0

var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO

var going_up = false
var direction = 1


# Define wall states
enum WallState { NORMAL, GREEN, BLUE }

# Export state so you can set it in the inspector
@export var state: WallState = WallState.NORMAL : set = set_state


func _ready():
	set_state(state) 
	#$Timer.wait_time = move_time
	start_pos = global_position
	#GlobalSignal.connect("platform", _movement)

func set_state(new_state: WallState) -> void:
	state = new_state
	match state:
		WallState.NORMAL:
			collision_layer = 1 << 5 #6
			collision_mask = 1 << 1 | 1 << 2  # both players
			%wallmesh.modulate = Color(0.353, 0.494, 0.651)
		WallState.GREEN:
			collision_layer = 1 << 6 #7
			collision_mask = 1 << 1      # only green collides
			%wallmesh.modulate = Color(0.11, 0.502, 0.11)
		WallState.BLUE:
			collision_layer = 1 << 7 #8
			collision_mask = 1 << 2      # only blue collides
			%wallmesh.modulate = Color(0.0, 0.498, 0.498)


func can_player_pass(player_color: String) -> bool:
	match state:
		WallState.NORMAL:
			return false  # nobody can pass
		WallState.GREEN:
			return player_color == "green"
		WallState.BLUE:
			return player_color == "blue"
	return false



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
