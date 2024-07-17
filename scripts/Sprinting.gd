class_name Sprinting


extends State

@onready var walkspeed = $"../..".walkSpeed

@export var player : CharacterBody3D
@export var animation : AnimationPlayer


func enter() -> void:
	animation.speed_scale += 0.5
	if animation.is_playing():
		if animation.current_animation == "crouch":
			animation.queue("Walking")
		else:
			animation.play("Walking")
	else:
		animation.play("Walking")

func exit() -> void:
	animation.speed_scale -=0.5




func update(delta):
	if !player.is_on_floor:
		transition.emit("Jumping")
	if player.velocity.length() <= walkspeed:
		transition.emit("Walking")
	if player.is_crouching==true:
		transition.emit("CrouchWalk")
