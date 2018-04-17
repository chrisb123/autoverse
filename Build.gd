extends MenuButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var popup
var placing_item
var object_to_place
var object_id
onready var camera = get_node("/root/Main/Camera")


func _ready():
	popup = get_popup()
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	#print(ID, "  ", popup.get_item_text(ID))
	#print(camera.get_grid())
	_get_object(ID)
	camera.set_placement(true) #set placment flag in camera
	placing_item = true
	
func _process(delta):
	if placing_item == true:
		_get_grid(object_to_place)

func _get_object(object_id):
	if object_id == 0:
		object_to_place = get_node("Character2")
	elif object_id == 1:
		object_to_place = get_node("Character3")	
	return object_to_place

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
	if placing_item:
		if event is InputEventMouseButton:
			if event.get_button_index() == 1 and event.is_pressed():
				_check_place_item()
			if event.get_button_index() == 2 and event.is_pressed():
				_cancel_build()


	