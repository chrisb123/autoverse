extends MenuButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var popup
var placing_item
var object_to_place
var object_size #Should probably be a vector2 or 3
var object_id
onready var camera = get_node("/root/Main/Camera")
onready var grid_map = get_node("/root/Main/GridMap")
var factory1 = load("res://Models/factory1.dae")
var factory2 = load("res://Models/factory2.dae")
var belt = load("res://Models/belt.dae")

func _ready():
	popup = get_popup()
	popup.add_item("Crap Belt")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(object_id):
	#print(ID, "  ", popup.get_item_text(ID))
	#print(camera.get_grid())
	if object_id == 0:
		object_to_place = factory1.instance()
		object_size = 2
	elif object_id == 1:
		object_to_place = factory2.instance()
		object_size = 2
	elif object_id == 2:
		object_to_place = belt.instance()
		object_size = 1
	add_child(object_to_place)
	camera._set_placement(true) #set placment flag in camera
	placing_item = true
	
func _process(delta):
	if placing_item == true:
		_get_grid(object_to_place)

func _get_grid(object_to_place):
		object_to_place.translation.x = camera._get_grid().x
		object_to_place.translation.z = camera._get_grid().z #should probably use 3 values
		
func _check_place_object():
	if grid_map._is_grid_empty(object_to_place.translation.x, object_to_place.translation.z,object_size): # true is always implied when there is no comparison
		_place_object_allowed()
	else:
		_place_object_error()

func _place_object_allowed():
	print("----- GRID EMPTY -----")	
	grid_map._set_grid_contents(object_to_place.translation.x, object_to_place.translation.z, 1, object_size) #todo test value, change to obj id
	_reset_build()
		
func _place_object_error():
	print("----- GRID FULL -----")	
#	remove_child(object_to_place)	#Place it elswhere
#	_reset_build()
	
func _cancel_build(): #todo
	remove_child(object_to_place)	
	_reset_build()
	pass	

func _reset_build(): #todo
	camera._set_placement(false) #clear placment flag in camera
	placing_item = false
	pass

#MOUSE CONTROLS

func _input(event):
	if event is InputEventMouseButton and placing_item: #use and dont nest inside another if statement
		if event.get_button_index() == 1 and event.is_pressed():
			_check_place_object()
		elif event.get_button_index() == 2 and event.is_pressed():
			_cancel_build()
		elif event.get_button_index() == 4:
			object_to_place.rotation_degrees.y += 45
		elif event.get_button_index() == 5:
			object_to_place.rotation_degrees.y -= 45


	