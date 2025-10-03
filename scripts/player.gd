extends CharacterBody2D

const speed = 20
const JUMP_VELOCITY = -400.0

var direction := Vector2.ZERO
var gravity = 50

var array = []
var face_in_this_direction

@export var can_move = true
@export var power_scale : float = 1.5

enum PlayerState { IDLE, CELEBRATING }
@export var state: PlayerState = PlayerState.IDLE : set = set_state

var device_id: int = 1

var device_ok: bool = true


func _ready() -> void:
	set_state(state)
	GlobalSignal.powerup.connect(_power_achieved)
	GlobalSignal.player_celebrating.connect(_celebrating)
	#GlobalSignal.connect("powerup", _power_achieved)
	#GlobalSignal.connect("player_celebrating", _celebrating)

func set_state(new_state: PlayerState) -> void:
	state = new_state
	match state:
		PlayerState.IDLE:
			$PlayerAnimation.play("idle")
		PlayerState.CELEBRATING:
			$PlayerAnimation.play("celebrating")


func _celebrating(person):
	if person == "player1":
		$PlayerAnimation.play("celebrating")
		can_move = false

func _power_achieved(owner, power):
	if owner == "player1" :
		if power == 0:
			scale = scale / power_scale
			print("player1 gets smaller")
		elif power == 1:
			print("player1 gets big")

func _unhandled_input(event: InputEvent) -> void:
	print ("player 1 ", event.device)

	device_ok = event.device == device_id
	

func _physics_process(delta: float) -> void:
	direction.x = 0
	#direction.y += gravity * delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.


	if device_ok or !GlobalVars.using_joystick:
		
		if Input.is_action_just_pressed("p1_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
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
		
		if can_move :
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
		

	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var item = collision.get_collider()
		if item and item.has_method("lever_state"):
			item.lever_state(true)
			#print(item)
			#if wall.lever_state(player_color):
				## Push through by applying leftover velocity
				#global_position += velocity * get_physics_process_delta_time()
	#
	
	
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
