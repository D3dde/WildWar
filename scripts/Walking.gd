class_name Walking

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	animation.queue("Walking")

func update(delta):
	if player.velocity.length() == 0.0 and player.is_crouching == false:
		transition.emit("Idle")
	if player.velocity.length() > 0.0 and player.is_crouching == true:
		transition.emit("CrouchWalk")
	if !player.is_on_floor():
		transition.emit("Jumping")
