extends Node2D

@export var linked_objects : Array[Node2D]
var pressed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") and !pressed:
		_use_linked_object()
		#GlobalSignal.emit_signal("floor_trap", "close")
		
	elif body.is_in_group("player2") and !pressed:
		_use_linked_object()
	

func _use_linked_object():
	if !pressed:
		$AnimationPlayer.play("pressed")
		pressed = true
		for object in linked_objects:
				if object.has_method("use_me"):
					object.use_me(true)
	else:
		$AnimationPlayer.play("relessed")
		pressed = false
		for object in linked_objects:
			if object.has_method("use_me"):
				object.use_me(false)
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player1") and pressed:
		_use_linked_object()
	elif body.is_in_group("player2") and pressed:
		_use_linked_object()
