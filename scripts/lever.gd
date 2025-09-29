extends StaticBody2D


@export var linked_objects : Array[Node2D]
#var pulled : bool = false
var can_pull : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func lever_state(state):
	if state :
		if can_pull:
			can_pull = false
			$Audio.playing = true
			# Trigger camera shake
			var camera = get_viewport().get_camera_2d()
			if camera and camera.has_method("shake"):
				camera.shake()
			#%lever.animation = "on"
			#await get_tree().create_timer(0.5).timeout
			_lever_movement("on")
			#for object in linked_objects:
				#if object.has_method("use_me"):
					#object.use_me(true)
		#else:
			#can_pull = true
			#_lever_movement("off")

	#if state :
		#if can_pull:
			#if !pulled:
				#can_pull = false
				#pulled = true
				#_lever_movement("on")
			#else:
				#can_pull = true
				#pulled = false
				#_lever_movement("off")

func _lever_movement(action):
	print(action)
	if action == "on":
		%lever.animation = "on"
		#await get_tree().create_timer(0.5).timeout
		#can_pull = true
		for object in linked_objects:
				if object.has_method("use_me"):
					object.use_me(true)
	#elif action == "off":
		#%lever.animation = "off"
		#can_pull = true
		#await get_tree().create_timer(0.5).timeout
		#for object in linked_objects:
				#if object.has_method("use_me"):
					#object.use_me(false)
	#
