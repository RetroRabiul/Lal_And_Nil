extends StaticBody2D

# Define wall states
enum WallState { NORMAL, GREEN, BLUE }

# Export state so you can set it in the inspector
@export var state: WallState = WallState.NORMAL : set = set_state


func _ready() -> void:
	set_state(state) 

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


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#match state:
		#WallState.NORMAL:
			#%wallmesh.modulate = Color(0.353, 0.494, 0.651)
			#print("normal")
		#WallState.GREEN:
			#%wallmesh.modulate = Color(0.11, 0.502, 0.11)
			#print("green")
		#WallState.BLUE:
			#%wallmesh.modulate = Color(0.0, 0.498, 0.498)
			#print("blue")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func can_player_pass(player_color: String) -> bool:
	match state:
		WallState.NORMAL:
			return false  # nobody can pass
		WallState.GREEN:
			return player_color == "green"
		WallState.BLUE:
			return player_color == "blue"
	return false
