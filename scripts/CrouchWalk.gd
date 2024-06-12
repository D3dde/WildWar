class_name CrouchWalk

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	pass


func update(delta):
	if player.is_crouching == true and player.velocity.length() == 0:
		transition.emit("CrouchIdle")
	if player.is_crouching == false and player.velocity.length() > 0:
		transition.emit("Walking")
