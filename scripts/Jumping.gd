class_name jumping

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	pass

func update(delta):
	if player.is_on_floor():
		if player.velocity.length() > 0:
			transition.emit("Walking")
		if player.velocity.length() == 0:
			transition.emit("Idle")
