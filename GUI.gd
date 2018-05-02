extends Control

signal mouse_outside_gui
signal mouse_inside_gui

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var camera = get_node("/root/Main/Camera")

func _ready():
	self.rect_size = get_viewport().get_visible_rect().size
	#set_as_toplevel(true)
	pass

#func _process(delta):
#	pass
	


func _on_GUI_mouse_entered(): #why didnt you just send this signal direct to camera?
	emit_signal("mouse_inside_gui")


func _on_GUI_mouse_exited(): #why didnt you just send this signal direct to camera?
	emit_signal("mouse_outside_gui")
	

