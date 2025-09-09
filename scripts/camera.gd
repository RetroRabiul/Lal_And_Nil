extends Camera2D

@export var player1: NodePath
@export var player2: NodePath
@export var screen_margin: float = 575.0

var _player1_node: Node2D
var _player2_node: Node2D

func _ready():
	_player1_node = get_node(player1)
	_player2_node = get_node(player2)

func _process(delta):
	if not _player1_node or not _player2_node:
		return

	var screen_size = get_viewport_rect().size
	var p1_pos = _player1_node.global_position
	var p2_pos = _player2_node.global_position
	
  # Midpoint between players
	var target_position = (p1_pos + p2_pos) / 2

	# Determine limits
	var half_screen = screen_size / 2.0
	var left_limit = min(p1_pos.x, p2_pos.x) - screen_margin
	var right_limit = max(p1_pos.x, p2_pos.x) + screen_margin
	var top_limit = min(p1_pos.y, p2_pos.y) - screen_margin
	var bottom_limit = max(p1_pos.y, p2_pos.y) + screen_margin

	# Clamp target camera position so no player is off-screen
	target_position.x = clamp(target_position.x, left_limit + half_screen.x, right_limit - half_screen.x)
	target_position.y = clamp(target_position.y, top_limit + half_screen.y, bottom_limit - half_screen.y)
	#var world_bounds = Rect2(Vector2.ZERO, Vector2(5000, 3000)) # example size
	#target_position = world_bounds.clip_rect(Rect2(target_position - half_screen, screen_size)).position + half_screen
	global_position = target_position
