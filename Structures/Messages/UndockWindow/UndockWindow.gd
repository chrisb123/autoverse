extends WindowDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# ----- Until have a better idea of what we would use such a window for ill leave it at this.
var obj

onready var camera = get_node("HBoxContainer/ViewportContainer/Viewport/TextureRect/Camera")
#onready var specific = get_node("HBoxContainer")
onready var obj_map = get_node("/root/Main/ObjMap")
var object_specific = load("res://Structures/Messages/UndockWindow/Object_Specific.tscn")
var actor_specific = load("res://Structures/Messages/UndockWindow/Actor_Specific.tscn")

func _process(delta):
	#changes here are for testing, should probably seperate object windows and actor windows. they're different enough
	#to warrant seperate scripts. should handle like Objects, same base script, and then specific script on top.
	#Perhaps cutout the VBoxContainer to seperete scenes and add as children ? (everything above is standard between them)
	#poor implementation of camera following. at the moment just testing
	if obj.is_in_group("Actor"):
		var grid_location = obj_map._get_actor_grid(obj)
		#labels.get_node("Label3").text = str("Grid Loc: ",grid_location)
		camera.look_at_from_position(obj.translation + Vector3(0,3,3), obj.translation, Vector3(0,1,0))
	else:
		pass
		#labels.get_node("Label5").text = str("Input Queue: ",obj.get_node("Obj").input_q)
		#labels.get_node("Label6").text = str("Output Queue: ",obj.get_node("Obj").output_q)
		
func _ready():
	set_process(false)
	self.popup()
	set_as_toplevel(false)		#This was a BS Problem to find. defaults true, and when true GUI was disabled

func _initialize(object_id,text):
	obj = object_id
	if obj.is_in_group("Object"):
		var specific_to_add = object_specific.instance()
		$HBoxContainer.add_child(specific_to_add)
		specific_to_add._set_labels(object_id,text)
		window_title = "Object Specific"
	elif obj.is_in_group("Actor"):
		var specific_to_add = actor_specific.instance()
		$HBoxContainer.add_child(specific_to_add)
		specific_to_add._set_labels(object_id,text)
		window_title = "Actor Specific"
	_set_camera(object_id)
	#_set_labels(object_id,text)
	
	
	
func _set_camera(object_id):
	camera.look_at_from_position(object_id.translation + Vector3(0,3,3), object_id.translation, Vector3(0,1,0))

#func _set_labels(object_id,text):
	#only examples
	#labels.get_node("Label").text = str("Text: ",text)
	#labels.get_node("Label2").text = str("Name: ",object_id)
	#labels.get_node("Label3").text = str("Grid Loc: ",object_id.translation)
	#labels.get_node("Label4").text = str("Group Name: ",object_id.get_groups())
	#set_process(true)

	
	

#func _process(delta):
#	print($Viewport.get_camera())
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CheckButton_toggled(button_pressed):
	obj.get_node("Obj").enabled = button_pressed
