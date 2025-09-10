extends Area2D

# Define wall states
enum powerups { SMALL, BIG }

# Export state so you can set it in the inspector
@export var power: powerups = powerups.SMALL : set = set_powerup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_powerup(power) 

func set_powerup(set_power: powerups) -> void:
	power = set_power
	match power:
		powerups.BIG:
			%PowerUp_Big.show()
			%PowerUp_Small.hide()
			print("Power BIG")
		powerups.SMALL:
			%PowerUp_Big.hide()
			%PowerUp_Small.show()
			print("Power SMALL")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1"):
		GlobalSignal.powerup.emit("player1", power)
		queue_free()
		
	if body.is_in_group("player2"):
		GlobalSignal.powerup.emit("player2", power)
		queue_free()
