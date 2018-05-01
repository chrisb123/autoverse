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
	


func _on_GUI_mouse_entered():
	print("entered gui")
	emit_signal("mouse_inside_gui")
	pass # replace with function body


func _on_GUI_mouse_exited():
	emit_signal("mouse_outside_gui")
	print("exited gui")
	pass # replace with function body
