extends ToolButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#Example call
#	#--add message to the bottom and shifts the upwards as new ones are added--
#	message_to_add = message.instance()	
#	message_window_vbox.add_child(message_to_add)
#	message_to_add._initialize(str("Grid ", object_to_place.translation, " occupied!"),"godot",5)
#	#--need to ensure scroll bar is always at bottom after adding new message--
#	yield(get_tree(), "idle_frame")
#	message_window.set_v_scroll(99999999)

var godot = load("res://Images/icon.png")
var error = load("res://Images/Error.png")

func _ready():
	pass

func _initialize(text,icon,time_to_die):
	if text == (""):
		pass
	else:
		self.text = text
	if icon == (""):
		pass
	else:
		self.icon = get(icon)
		self.rect_scale.x = 0.5
		self.rect_scale.y = 0.5
	if time_to_die == 0:
		pass
	else:
		$Time_To_Die.wait_time = time_to_die
		$Time_To_Die.start()
		
	
func _process():
#	if self.pressed:
		
	pass


func _on_Time_To_Die_timeout():
	queue_free()
	pass # replace with function body
