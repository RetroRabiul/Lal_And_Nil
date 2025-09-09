extends Node2D

@export var trap_closed : bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if trap_closed:
		$FloorTrapAnimation.play("close")
	else:
		$FloorTrapAnimation.play("Open")
	#GlobalSignal.connect("floor_trap", _trap_state)


func use_me(action):
	if action :
		if trap_closed:
			trap_closed = false
			$FloorTrapAnimation.play("Open")
		else:
			trap_closed = true
			$FloorTrapAnimation.play("close")
	elif !action:
		if trap_closed:
			trap_closed = false
			$FloorTrapAnimation.play("Open")
		else:
			trap_closed = true
			$FloorTrapAnimation.play("close")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
