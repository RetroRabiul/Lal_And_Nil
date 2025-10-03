extends Area2D

@export var move_to = Vector2.ZERO
@export var move_speed = 350


var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO

var going_up = false
var direction = 1



func _ready() -> void:
	
	start_pos = global_position


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1"):
		$Collected_Sound.playing = true
		print(self.global_position)
		# Trigger camera shake
		#var camera = get_viewport().get_camera_2d()
		#if camera and camera.has_method("shake"):
			#camera.shake()
		await get_tree().create_timer(0.1).timeout
		#await($Collected_Sound)
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player1", "player2")
		#GlobalSignal.key_icon.emit()
		print("Key",body)
		_begin_moving()
		
	
	if body.is_in_group("player2"):
		$Collected_Sound.playing = true
		print(self.global_position)
		# Trigger camera shake
		#var camera = get_viewport().get_camera_2d()
		#if camera and camera.has_method("shake"):
			#camera.shake()
		await get_tree().create_timer(0.1).timeout
		#await($Collected_Sound)
		GlobalVars.key = true
		GlobalSignal.key_owner.emit("player2", "player1")
		#GlobalSignal.key_icon.emit()
		print("Key",body)
		_begin_moving()

func _begin_moving():
	target_pos = Vector2(1836.0, 84.0)
	var dist = global_position.distance_to(target_pos)
	var move_time = dist/move_speed
	$Timer.wait_time = move_time
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_position", target_pos, move_time)
	tween.tween_property(self, "scale", Vector2(2.5,2.5), move_time)
	await get_tree().create_timer(move_time).timeout
	GlobalSignal.key_icon.emit()
	queue_free()
