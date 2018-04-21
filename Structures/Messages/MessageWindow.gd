extends ScrollContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var message = load("res://Structures/Messages/Message.tscn")

func _ready():
	self.rect_size.x = 310
	self.rect_size.y = 540
		# Called every time the node is added to the scene.
	# Initialization here
	pass

func _add_msg(msg,icon,time):
	var message_to_add = message.instance()	
	$VBox.add_child(message_to_add)
	message_to_add._initialize(msg,icon,time)
	yield(get_tree(), "idle_frame")
	set_v_scroll(99999999)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
