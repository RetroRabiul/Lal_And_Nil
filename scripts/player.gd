extends CharacterBody2D

const speed = 20
const JUMP_VELOCITY = -400.0

var direction := Vector2.ZERO
var gravity = 50

var array = []
var face_in_this_direction

var can_move = true
@export var power_scale : float = 1.5


func _ready() -> void:
	can_move = true
	GlobalSignal.connect("powerup", _power_achieved)
	GlobalSignal.connect("player_celebrating", _celebrating)


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


func _physics_process(delta: float) -> void:
	direction.x = 0
	#direction.y += gravity * delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	
	#for body in get_overlapping_bodies():
		#if body is StaticBody2D and body.has_variable("state"):
			#var can_pass = false
			#match body.state:
				#body.WallState.NORMAL:
					#can_pass = false
				#body.WallState.GREEN:
					#can_pass = player_color == "green"
				#body.WallState.BLUE:
					#can_pass = player_color == "blue"
					#
			#if can_pass:
				## Turn off collision mask for this wall
				#set_collision_mask_value(body.collision_layer, false)
			#else:
				## Turn it back on
				#set_collision_mask_value(body.collision_layer, true)
		## No wall or normal object → move freely
		#
	
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
