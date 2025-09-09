extends CharacterBody2D

const speed = 20
const JUMP_VELOCITY = -20.0

var direction := Vector2.ZERO
var gravity = 50

var array = []
var face_in_this_direction


@export var player_color: String = "green"  # or "blue"


func _physics_process(delta: float) -> void:
	direction.x = 0
	direction.y += gravity * delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		direction.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#if Input.is_action_just_pressed("show_ui"):
		#GlobalSignal.emit_signal("ui_state")
	
	
	if Input.is_action_just_pressed("p1_left"):
		array.append("p1_left")
		#
		#direction.x -= speed
		#$PlayerAnimation.play("walk")
		#$PlayerAnimation.flip_h = true
		
	
	if Input.is_action_just_released("p1_left"):
		if "p1_left" in array:
			array.erase("p1_left")
	
	
	if Input.is_action_just_pressed("p1_right"):
		array.append("p1_right")
		
		#direction.x += speed
		#$PlayerAnimation.play("walk")
		#$PlayerAnimation.flip_h = false
	
	if Input.is_action_just_released("p1_right"):
		if "p1_right" in array:
			array.erase("p1_right")
		
	
	if not array.is_empty():
		var last_direction = array.size() - 1
		face_in_this_direction = array[last_direction]
		
		#print ("MOVE TO ", face_in_this_direction)
	else:
		face_in_this_direction = "stop"
	
	
	match face_in_this_direction:
		"p1_left":
			direction.x -= speed
			$PlayerAnimation.play("walk")
			$PlayerAnimation.flip_h = true
		
		"p1_right":
			direction.x += speed
			$PlayerAnimation.play("walk")
			$PlayerAnimation.flip_h = false
		
		"stop":
			$PlayerAnimation.play("idle")
	
	var collision = move_and_collide(velocity * delta)
	if collision and collision.get_collider().has_method("can_player_pass"):
		var wall = collision.get_collider()
		if wall.can_player_pass(player_color):
			# If allowed to pass → use move_and_slide (ignores collision)
			move_and_slide()
		else:
			# Not allowed → do real collide
			move_and_collide(velocity * delta)
	else:
		# No wall or normal object → move freely
		move_and_slide()

	
	
	#
	#var direction := Input.get_axis("p1_left", "p1_right")
	#if direction:
		#velocity.x = direction * speed
		#
		#
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#$AnimatedSprite2D.play("idle")
	#
	
	velocity = direction * speed
	velocity.normalized()
	
	move_and_slide()
	
	#var isLeft = velocity.x < 0 
	#$AnimatedSprite2D.flip_h = isLeft
