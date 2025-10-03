extends CharacterBody2D

const speed = 20
const JUMP_VELOCITY = -400.0

var direction := Vector2.ZERO
var gravity = 50

var array = []
var face_in_this_direction


@export var can_move = true
@export var power_scale : float = 1.5

var device_ok: bool = true

enum PlayerState { IDLE, CELEBRATING }
@export var state: PlayerState = PlayerState.IDLE : set = set_state

var device_id: int = 0

func _ready() -> void:
	set_state(state)
	GlobalSignal.connect("powerup", _power_achieved)
	GlobalSignal.connect("player_celebrating", _celebrating)


func set_state(new_state: PlayerState) -> void:
	state = new_state
	match state:
		PlayerState.IDLE:
			$PlayerAnimation.play("idle")
		PlayerState.CELEBRATING:
			$PlayerAnimation.play("celebrating")




func _celebrating(person):
	if person == "player2":
		$PlayerAnimation.play("celebrating")
		can_move = false

func _power_achieved(owner, power):
	if owner == "player2" :
		if power == 0:
			scale = scale / power_scale
			print("player2 gets smaller")
		elif power == 1:
			print("player2 gets big")
			
			

func _unhandled_input(event: InputEvent) -> void:
	print ("player 2 ", event.device)

	device_ok = event.device == device_id

	




func _physics_process(delta: float) -> void:
	direction.x = 0
	#direction.y += gravity * delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if device_ok or !GlobalVars.using_joystick:
	
		# Handle jump.
		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY


		
		
		if Input.is_action_just_pressed("p2_left"):
			array.append("p2_left")

			
		
		if Input.is_action_just_released("p2_left"):
			if "p2_left" in array:
				array.erase("p2_left")
		
		
		if Input.is_action_just_pressed("p2_right"):
			array.append("p2_right")
			

		
		if Input.is_action_just_released("p2_right"):
			if "p2_right" in array:
				array.erase("p2_right")
			
		
		if not array.is_empty():
			var last_direction = array.size() - 1
			face_in_this_direction = array[last_direction]
			
			#print ("MOVE TO ", face_in_this_direction)
		else:
			face_in_this_direction = "stop"
		
		if can_move :
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
		
	
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var item = collision.get_collider()
		if item and item.has_method("lever_state"):
			item.lever_state(true)
	
		
	
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
	
	velocity.x = direction.x * speed
	velocity.normalized()
	
	move_and_slide()
	
	#var isLeft = velocity.x < 0 
	#$AnimatedSprite2D.flip_h = isLeft
