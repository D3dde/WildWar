class_name Idle

extends State

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	if animation.is_playing():
		if !animation.current_animation == "crouch":
			animation.stop()


func update(delta):
	if player.velocity.length() > 0.0 and player.is_on_floor():
		transition.emit("Walking")
	if player.is_on_floor() and player.is_crouching == true:
		transition.emit("CrouchIdle")
	if !player.is_on_floor():
		transition.emit("Jumping")

