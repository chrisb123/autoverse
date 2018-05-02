extends MenuButton

var popup
var placing_item
var object_to_place
var object_id
onready var camera = get_node("/root/Main/Camera")
onready var grid_map = get_node("/root/Main/GridMap")
onready var gui = get_node("/root/Main/GUI")
onready var message_window = get_node("/root/Main/GUI/MessageWindow")
var factory1 = load("res://Structures/factory1.tscn")
var factory2 = load("res://Structures/factory2.tscn")
var factory3 = load("res://Structures/factory3.tscn")
var belt = load("res://Structures/belt.tscn")
var arm = load("res://Structures/arm.tscn")
var mine = load("res://Structures/mine.tscn")
var split = load("res://Structures/split.tscn")

func _ready():
	popup = get_popup()
	popup.add_item("Crap Belt")
	popup.add_item("Feed Arm")
	popup.add_item("Mine")
	popup.add_item("Splitter")
	popup.add_item("Wide Factory")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(object_id):
	#print(ID, "  ", popup.get_item_text(ID))
	#print(camera.get_grid())
	if object_id == 0:
		object_to_place = factory1.instance()
	elif object_id == 1:
		object_to_place = factory2.instance()
	elif object_id == 2:
		object_to_place = belt.instance()
	elif object_id == 3:
		object_to_place = arm.instance()
	elif object_id == 4:
		object_to_place = mine.instance()
	elif object_id == 5:
		object_to_place = split.instance()
	elif object_id == 6:
		object_to_place = factory3.instance()
	
	add_child(object_to_place)
	camera._set_placement(true) #set placment flag in camera
	placing_item = true
	
func _process(delta):
	if placing_item == true:
		_get_grid(object_to_place)

func _get_grid(object_to_place):
	object_to_place.translation = camera._get_grid()
		
func _check_place_object():
	if grid_map._is_grid_empty(object_to_place): # true is always implied when there is no comparison, size and translation is part of obj no need to pass seperate parameters
		_place_object_allowed()
	else:
		_place_object_error()

func _place_object_allowed():
	print("----- GRID EMPTY -----")	
	remove_child(object_to_place)	
	grid_map.add_child(object_to_place)
	object_to_place._set_facing(object_to_place.rotation_degrees.y)
	grid_map._set_grid_contents(object_to_place)
	object_to_place._start() #execute base script methods
	object_to_place.get_node("Obj")._start() #execute obj specific methods
	_reset_build()
		
func _place_object_error():
	print("----- GRID FULL -----")
	#Example of message call
	#Put message code in message node and call it all as one function
	#(Short Text, icon to display, timeout (0s disabled), Longtext ("" = disabled), Object ID,is_undockable)
	var obj_err = grid_map._is_grid_empty(object_to_place, true) #true returns item id
	message_window._add_msg(str("Grid ", object_to_place.translation, " occupied!"),"godot",5,"Example long text blah blah blah",obj_err,true) #msg with the works
	message_window._add_msg(str("Grid ", object_to_place.translation, " occupied!")) #basic message with default values
	
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
	if event is InputEventMouseButton and placing_item and event.is_pressed() and gui.mouse_in_main_gui: #use and dont nest inside another if statement
		if event.get_button_index() == 1:
			_check_place_object()
		elif event.get_button_index() == 2:
			_cancel_build()
		elif event.get_button_index() == 4:		#needs is pressed otherwise processes multiple times
			object_to_place.rotation_degrees.y += 90
			if object_to_place.rotation_degrees.y >= 360:
				object_to_place.rotation_degrees.y = 0
		elif event.get_button_index() == 5: 	#needs is pressed otherwise processes multiple times
			object_to_place.rotation_degrees.y -= 90
			if object_to_place.rotation_degrees.y <= -90:
				object_to_place.rotation_degrees.y = 270
		#object_to_place.rotation_degrees.y = round(object_to_place.rotation_degrees.y) #reduces inaccuracy creeping in. 360 and below degrees seems to not be needed
