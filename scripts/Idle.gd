class_name Idle

extends State

@onready var walkspeed = $"../..".walkSpeed

@export var player : CharacterBody3D
@export var animation : AnimationPlayer

func enter() -> void:
	pass


func update(delta):
	if animation.is_playing():
		if animation.current_animation == "Walking":
			animation.stop()
	if player.velocity.length() != 0 and player.velocity.length() <= walkspeed and player.is_on_floor():
		transition.emit("Walking")
	if player.is_on_floor() and player.is_crouching == true:
		transition.emit("CrouchIdle")
	if !player.is_on_floor():
		transition.emit("Jumping")
	
