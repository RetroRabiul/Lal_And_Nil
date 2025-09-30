extends Area2D

@export var move_to = Vector2.ZERO
@export var move_time = 0.5

var start_pos = Vector2.ZERO
var target_pos = Vector2.ZERO

var going_up = false
var direction = 1

func _ready() -> void:
	$Timer.wait_time = move_time
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
	target_pos = start_pos + move_to
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, move_time)
	tween.tween_property(self, "scale", Vector2(2.5,2.5), move_time)
	await get_tree().create_timer(3).timeout
	GlobalSignal.key_icon.emit()
	queue_free()
