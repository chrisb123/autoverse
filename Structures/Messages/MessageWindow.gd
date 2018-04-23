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
#use preset values so you can create function with different number of variables
#msg is probably the one thing required, the rest are optional
#order is importan try to sort them in order of importance or use
#e.g. msg, longtext, object_id, undock, icon, time might be a sugestion, depends what will be used more
#use null or false avoid using "" empty string
func _add_msg(msg,icon = "godot",time = 5,longtext = null, object_id = null,undockable = false): 
	print(longtext)
	var message_to_add = message.instance()	
	$VBox.add_child(message_to_add)
	message_to_add._initialize(msg,icon,time,longtext,object_id,undockable)
	yield(get_tree(), "idle_frame")
	set_v_scroll(99999999)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
