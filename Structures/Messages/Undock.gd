extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var UndockWindow = load("res://Structures/Messages/UndockWindow.tscn")
onready var gui = get_tree().get_root().get_node("/root/Main/GUI/")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#$WindowDialog.popup()
	pass

func _initialize(undockable):
	if undockable == false:
		self.hide()
	else:
		self.show()

func _pressed():
		var window_to_add = UndockWindow.instance()
		gui.add_child(window_to_add)
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
