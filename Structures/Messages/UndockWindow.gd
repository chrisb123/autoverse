extends WindowDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# ----- Until have a better idea of what we would use such a window for ill leave it at this.


onready var camera = get_node("HBoxContainer/ViewportContainer/Viewport/TextureRect/Camera")
onready var labels = get_node("HBoxContainer/VBoxContainer")

func _ready():
	self.popup()
	set_as_toplevel(false)		#This was a BS Problem to find. defaults true, and when true GUI was disabled

func _initialize(object_id,text):
	_set_camera(object_id)
	_set_labels(object_id,text)
	
func _set_camera(object_id):
	camera.look_at_from_position(object_id.translation + Vector3(0,3,3), object_id.translation, Vector3(0,1,0))

func _set_labels(object_id,text):
	#only examples
	labels.get_node("Label").text = str("Text: ",text)
	labels.get_node("Label2").text = str("Name: ",object_id)
	labels.get_node("Label3").text = str("Grid Loc: ",object_id.translation)
	labels.get_node("Label4").text = str("Group Name: ",object_id.get_groups())

	
	

#func _process(delta):
#	print($Viewport.get_camera())
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
