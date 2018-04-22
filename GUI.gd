extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.rect_size = get_viewport().get_visible_rect().size
	#set_as_toplevel(true)
	pass

#func _process(delta):
#	pass
	
