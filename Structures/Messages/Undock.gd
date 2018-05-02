extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var text_local
var object_id_local
var UndockWindow = load("res://Structures/Messages/UndockWindow/UndockWindow.tscn")
onready var gui = get_tree().get_root().get_node("/root/Main/GUI/")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#$WindowDialog.popup()
	pass

func _initialize(undockable, object_id, text):
	object_id_local = object_id
	text_local = text
	if undockable == false:
		self.hide()
	else:
		self.show()

func _pressed():
		var window_to_add = UndockWindow.instance()
		gui.add_child(window_to_add)
		window_to_add._initialize(object_id_local, text_local)
		#gui.move_child(window_to_add,0)
		#print(gui.get_children())

#func _process(delta):
#	if self.pressed:
#		#add window as child to GUI so message can be deleted, but undocked window stays. 
#		var window_to_add = UndockWindow.instance()
#		gui.add_child(window_to_add)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
