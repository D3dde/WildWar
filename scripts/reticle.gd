extends CenterContainer

@export var player : CharacterBody3D

#lines
@export var lines : Array[Line2D]
@export var reticle_speed := 0.25
@onready var reticle_distance=get_viewport().size[0]/500

#dot
@export var dot_radius : float = 1.50
@export var dot_color := Color.WHITE



func _ready():
	queue_redraw()

func _process(delta):
	adjust_reticle_lines()
	reticle_distance=get_viewport().size[0]/250


func _draw():
	draw_circle(Vector2(0,0),dot_radius,dot_color)



func adjust_reticle_lines():
	var vel = player.get_real_velocity()
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = origin.distance_to(vel)
	
	#movimento effettivo del reticolo 
	lines[0].position = lerp( lines[0].position , pos + Vector2(0 , -speed * reticle_distance ) , reticle_speed )
	lines[1].position = lerp( lines[1].position , pos + Vector2( -speed * reticle_distance , 0 ) , reticle_speed )
	lines[2].position = lerp( lines[2].position , pos + Vector2(0 , speed * reticle_distance ) , reticle_speed )
	lines[3].position = lerp( lines[3].position , pos + Vector2( speed * reticle_distance , 0 ) , reticle_speed )
