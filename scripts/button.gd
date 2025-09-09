extends StaticBody2D

@export var linked_objects : Array[Node2D]
var pressed : bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") and !pressed:
		_use_linked_object()
	elif body.is_in_group("player2") and !pressed:
		_use_linked_object()
	

func _use_linked_object():
	if !pressed:
		%ButtonAnimation.play("pressed")
		pressed = true
		for object in linked_objects:
				if object.has_method("use_me"):
					object.use_me(true)
	else:
		%ButtonAnimation.play("relessed")
		pressed = false
		for object in linked_objects:
			if object.has_method("use_me"):
				object.use_me(false)
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player1") and pressed:
		_use_linked_object()
	elif body.is_in_group("player2") and pressed:
		_use_linked_object()
