extends CharacterBody3D


@export var select_toggle_crouch := false

const sprintSeed = 7.5
const walkSpeed = 5.0
const crouchSpeed = 3.0
var  is_sprinting = false
var SPEED = walkSpeed
const JUMP_VELOCITY = 4.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=5


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@export var camera : Camera3D
@export var animation_player: AnimationPlayer


@export var sens : float = 3.0


var is_crouching : bool = false
@export var crouch_shape : ShapeCast3D




func _ready():
	# crouch collision fix
	crouch_shape.add_exception(self)
	
	# mouse
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	
	# easier sens controller (@export var sens : float)
	sens /= 1000



func _input(event):
	if event.is_action_pressed("crouch") and select_toggle_crouch == true:
		toggle_crouch()
	if event.is_action_pressed("crouch") and select_toggle_crouch == false and crouch_shape.is_colliding() == false and is_crouching==false:
		crouch(true)
	if event.is_action_released("crouch") and select_toggle_crouch == false and crouch_shape.is_colliding() == false and is_crouching==true:
		crouch(false)
	
	#sprint
	if event.is_action_pressed("sprint") and is_crouching==false and velocity.length() != 0 and Input.is_action_pressed("up"):
		is_sprinting = true
		SPEED = sprintSeed
	if event.is_action_released("up"):
		is_sprinting = false
		SPEED = walkSpeed
	if event.is_action_pressed("crouch"):
		is_sprinting = false
	



# mouse
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sens)
		camera.rotate_x(-event.relative.y * sens)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)



# mouse
func _unhandled_key_input(event):
	if Input.is_action_just_pressed("exit"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED




func _physics_process(delta):
	# quality of life crouch
	if is_crouching == true:
		if crouch_shape.is_colliding()== false and select_toggle_crouch == false and !Input.is_action_pressed("crouch"):
			toggle_crouch()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	
	
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED and Input.is_action_pressed("crouch")==false:
		if is_crouching==true:
			toggle_crouch()
		else:
			velocity.y += JUMP_VELOCITY
	
	# handle fov
	var tween := create_tween()
	if is_sprinting:
		tween.tween_property(camera, "fov", 75.0 + 20.0, 0.2)
	else:
		tween.tween_property(camera, "fov", 95.0 - 20.0, 0.2)
	
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Vector3.ZERO
	var movetoward = Vector3.ZERO
	input_dir.x = Input.get_vector("left", "right", "up", "down").x
	input_dir.y = Input.get_vector("left", "right", "up", "down").y
	input_dir=input_dir.normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction *= SPEED
	velocity.x = move_toward(velocity.x,direction.x, HORIZONTAL_ACCELERATION * delta)
	velocity.z = move_toward(velocity.z,direction.z, HORIZONTAL_ACCELERATION * delta)
	
	
	# camera tilt rotation
	var angle=2.5
	var t = delta * 6
	if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
		rotation_degrees=rotation_degrees.lerp(Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle),t)
	
	move_and_slide()
	force_update_transform()


# if select_toggle_crouch == true
func toggle_crouch():
	if is_crouching == true and crouch_shape.is_colliding() == false:
		crouch(false)
	elif is_crouching == false:
		crouch(true)


# small function for crounch
func crouch(state : bool):
	match state:
		true:
			animation_player.play("crouch")
			SPEED = crouchSpeed
			is_crouching = !is_crouching
		false:
			animation_player.play_backwards("crouch")
			SPEED = walkSpeed
			is_crouching = !is_crouching
