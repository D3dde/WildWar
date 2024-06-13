class_name jumping

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	pass

func update(delta):
	if player.is_on_floor():
		if player.velocity.length() > 0:
			if player.is_crouching == false:
				transition.emit("Walking")
			elif player.is_crouching == true:
				transition.emit("CrouchWalk")
		if player.velocity.length() == 0:
			transition.emit("Idle")
