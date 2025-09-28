extends Control

@onready var input_code = %LevelCode

#@onready var my_button :  Button = %PlayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#%PlayButton.disabled = true
	input_code.text = GlobalVars.level1_code
	# Check if level 1 was completed
	if GlobalVars.level1_completed:
		%Level_1.modulate = Color(0, 255, 0, 255)
	if GlobalVars.level2_completed:
		%Level_2.modulate = Color(0, 255, 0, 255)
	if GlobalVars.level3_completed:
		%Level_3.modulate = Color(0, 255, 0, 255)
	if GlobalVars.level4_completed:
		%Level_4.modulate = Color(0, 255, 0, 255)
	if GlobalVars.level5_completed:
		%Level_5.modulate = Color(0, 255, 0, 255)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("play"):
		_on_button_pressed()
		#my_button.button_pressed = true


func _on_button_pressed() -> void:
		_change_scene()

func _on_level_code_text_changed() -> void:
	if input_code.text.length() > 6:
		input_code.text = ""
		#show press play
		#%PlayButton.disabled = false
		print(%LevelCode.text)
		


func _change_scene():
	if input_code.text == GlobalVars.level1_code:
		get_tree().change_scene_to_file("res://scenes/One_Platform_Short.tscn")
	elif input_code.text == GlobalVars.level2_code:
		get_tree().change_scene_to_file("res://scenes/Oops_a_trap.tscn")
	elif input_code.text == GlobalVars.level3_code:
		get_tree().change_scene_to_file("res://scenes/Mind_the_Gap.tscn")
	elif input_code.text == GlobalVars.level4_code:
		get_tree().change_scene_to_file("res://scenes/Almost_Made_It.tscn")
	elif input_code.text == GlobalVars.level5_code:
		get_tree().change_scene_to_file("res://scenes/One_Step_Away.tscn")
	else:
		%LevelCode.text = "ENTER CODE"
		print("GameOver")
		


func _on_level_1_pressed() -> void:
	$Button_Pressed_Sound.playing = true
	input_code.text = GlobalVars.level1_code
	#%Level_1.modulate = Color(0, 255, 0 ,255)


func _on_level_2_pressed() -> void:
	$Button_Pressed_Sound.playing = true
	if GlobalVars.level2_unlocked == true or GlobalVars.level2_completed == true:
		#%Level_2.modulate = Color(0, 255, 0 ,255)
		input_code.text = GlobalVars.level2_code
	else:
		input_code.text = ""


func _on_level_3_pressed() -> void:
	$Button_Pressed_Sound.playing = true
	if GlobalVars.level3_unlocked == true or GlobalVars.level3_completed == true:
		#%Level_3.modulate = Color(0, 255, 0 ,255)
		input_code.text = GlobalVars.level3_code
	else:
		input_code.text = ""


func _on_level_4_pressed() -> void:
	$Button_Pressed_Sound.playing = true
	if GlobalVars.level4_unlocked == true or GlobalVars.level4_completed == true:
		#%Level_3.modulate = Color(0, 255, 0 ,255)
		input_code.text = GlobalVars.level4_code
	else:
		input_code.text = ""


func _on_level_5_pressed() -> void:
	$Button_Pressed_Sound.playing = true
	if GlobalVars.level5_unlocked == true or GlobalVars.level5_completed == true:
		#%Level_3.modulate = Color(0, 255, 0 ,255)
		input_code.text = GlobalVars.level5_code
	else:
		input_code.text = ""
