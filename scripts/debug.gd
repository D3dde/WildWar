extends PanelContainer

@export var container : VBoxContainer

var property
var fps : String

func _ready():
	visible = false
	add_debug_property("FPS",fps)

func _process(delta):
	if visible:
		fps = "%.2f" % (1.0/delta)
		property.text = property.name + ": " + fps


func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible

func add_debug_property(title : String,value):
	property = Label.new()
	container.add_child(property)
	property.name = title
	property.text = property.name + value
