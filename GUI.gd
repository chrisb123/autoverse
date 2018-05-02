extends Control

var mouse_in_main_gui = true

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.rect_size = get_viewport().get_visible_rect().size
	#set_as_toplevel(true)
	pass

#func _process(delta):
#	pass
	


func _on_GUI_mouse_entered(): #why didnt you just send this signal direct to camera?
	mouse_in_main_gui = true


func _on_GUI_mouse_exited(): #why didnt you just send this signal direct to camera?
	mouse_in_main_gui = false
	

