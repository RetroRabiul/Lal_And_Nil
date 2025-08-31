extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FloorTrapAnimation.play("Open")
	#GlobalSignal.connect("floor_trap", _trap_state)

func use_me(action):
	if action:
		$FloorTrapAnimation.play("close")
	else:
		$FloorTrapAnimation.play("Open")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
