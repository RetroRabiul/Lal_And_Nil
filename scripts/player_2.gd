extends CharacterBody2D

const speed = 20
const JUMP_VELOCITY = -20.0

var direction := Vector2.ZERO
var gravity = 50

var array = []
var face_in_this_direction

@export var power_scale : float = 1.5


func _ready() -> void:
	GlobalSignal.connect("powerup", _power_achieved)


func _power_achieved(owner, power):
	if owner == "player2" :
		if power == 0:
			scale = scale / power_scale
			print("player2 gets smaller")
		elif power == 1:
			print("player2 gets big")


func _physics_process(delta: float) -> void:
	direction.x = 0
	direction.y += gravity * delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p2_jump") and is_on_floor():
		direction.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	if Input.is_action_just_pressed("p2_left"):
		array.append("p2_left")
		#
		#direction.x -= speed
		#$PlayerAnimation.play("walk")
		#$PlayerAnimation.flip_h = true
		
	
	if Input.is_action_just_released("p2_left"):
		if "p2_left" in array:
			array.erase("p2_left")
	
	
	if Input.is_action_just_pressed("p2_right"):
		array.append("p2_right")
		
		#direction.x += speed
		#$PlayerAnimation.play("walk")
		#$PlayerAnimation.flip_h = false
	
	if Input.is_action_just_released("p2_right"):
		if "p2_right" in array:
			array.erase("p2_right")
		
	
	if not array.is_empty():
		var last_direction = array.size() - 1
		face_in_this_direction = array[last_direction]
		
		#print ("MOVE TO ", face_in_this_direction)
	else:
		face_in_this_direction = "stop"
	
	
	match face_in_this_direction:
		"p2_left":
			direction.x -= speed
			$PlayerAnimation.play("walk")
			$PlayerAnimation.flip_h = true
		
		"p2_right":
			direction.x += speed
			$PlayerAnimation.play("walk")
			$PlayerAnimation.flip_h = false
		
		"stop":
			$PlayerAnimation.play("idle")
	
	
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
