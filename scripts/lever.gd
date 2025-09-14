extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lever_state(state):
	if state:
		_lever_movement("up")
	else:
		_lever_movement("down")

func _lever_movement(action):
	print(action)
	if action == "up":
		%lever.animation.play("up")
	elif action == "down":
		%lever.animation.play("down")
	
