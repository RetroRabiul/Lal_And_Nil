extends Node2D

var trap_closed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FloorTrapAnimation.play("Open")
	#GlobalSignal.connect("floor_trap", _trap_state)

func use_me(action):
	if action and !trap_closed:
		trap_closed = true
		$FloorTrapAnimation.play("close")
	elif !action and trap_closed:
		trap_closed = false
		$FloorTrapAnimation.play("Open")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
