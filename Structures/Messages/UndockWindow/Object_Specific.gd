extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enabled = true setget set_enabled
var obj_id
signal state

func _ready():
	print("object specific")

func set_enabled(value):
	enabled = value
	$CheckButton.pressed = enabled

func _set_labels(object_id,text):
	#only examples
	obj_id = object_id
	$Label.text = str("Object: ",text)
	$Label2.text = str("Name: ",object_id)
	$Label3.text = str("Grid Loc: ",object_id.translation)
	$Label4.text = str("Group Name: ",object_id.get_groups())
	#set_process(true)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _process(delta):
	$Label5.text = "IN:"+str(obj_id.get_node("Obj").input_q.size())+"OUT:"+str(obj_id.get_node("Obj").output_q.size())
	if obj_id.is_in_group("mine"):
		$Label6.text = str(obj_id.get_node("Obj").resource)

func _on_CheckButton_toggled(button_pressed):
	enabled = button_pressed
	emit_signal("state", enabled)


func _on_Button_pressed():
	obj_id.destroy()
	get_parent().get_parent().queue_free()
