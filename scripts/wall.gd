extends StaticBody2D

# Define wall states
enum WallState { NORMAL, GREEN, BLUE }

# Export state so you can set it in the inspector
@export var state: WallState = WallState.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match state:
		WallState.NORMAL:
			%wallmesh.modulate = Color(0.353, 0.494, 0.651)
			print("normal")
		WallState.GREEN:
			%wallmesh.modulate = Color(0.11, 0.502, 0.11)
			print("green")
		WallState.BLUE:
			%wallmesh.modulate = Color(0.0, 0.498, 0.498)
			print("blue")


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
