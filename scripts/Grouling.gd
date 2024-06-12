class_name CrouchIdle

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	pass

func update(delta):
	if player.velocity.length() > 0 and player.is_crouching == true:
		transition.emit("CrouchWalk")
	if player.is_crouching == false:
		transition.emit("Idle")
