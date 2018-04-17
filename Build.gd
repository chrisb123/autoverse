extends MenuButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var popup
var placing_item
var object_to_place
var object_id
onready var camera = get_node("/root/Main/Camera")
var factory1 = load("res://Models/factory1.dae")
var factory2 = load("res://Models/factory2.dae")
var belt = load("res://Models/belt.dae")

func _ready():
	popup = get_popup()
	popup.add_item("Crap Belt")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	#print(ID, "  ", popup.get_item_text(ID))
	#print(camera.get_grid())
	_get_object(ID) # ??? huh ??? not assigned to anything
	camera.set_placement(true) #set placment flag in camera
	placing_item = true
	
func _process(delta):
	if placing_item == true:
		_get_grid(object_to_place)

func _get_object(object_id):
	if object_id == 0:
		object_to_place = factory1.instance()
	elif object_id == 1:
		object_to_place = factory2.instance()
	elif object_id == 2:
		object_to_place = belt.instance()
	add_child(object_to_place)
	return object_to_place # ??? Youre not assign this return to anything when called above ???

func _get_grid(object_to_place):
		object_to_place.visible = true
		object_to_place.translation.x = camera.get_grid().x
		object_to_place.translation.z = camera.get_grid().z
		
func _check_place_item():
	#Call function in Grid Map passing Object type and grid location to add into Grid Map Array
	#if empty Grid map adds data to array and returns CELL Empty
	#if grid map returns OK to place, then call _reset_build()
	#if grid map returns NOK to place, then Call _build_error()
	_reset_build() # missing Grid location confirmation
	pass		

func _reset_build(): #todo
	camera.set_placement(false) #clear placment flag in camera
	placing_item = false
	pass
	
func _build_error(): #todo
	pass
	
func _cancel_build(): #todo
	object_to_place.visible = false
	placing_item = false
	pass	

#MOUSE CONTROLS

func _input(event):
	if event is InputEventMouseButton and placing_item: #use and dont nest inside another if statement
		if event.get_button_index() == 1 and event.is_pressed():
			_check_place_item()
		elif event.get_button_index() == 2 and event.is_pressed():
			_cancel_build()
		elif event.get_button_index() == 4:
			object_to_place.rotation_degrees.y += 45
		elif event.get_button_index() == 5:
			object_to_place.rotation_degrees.y -= 45


	