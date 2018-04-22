extends WindowDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.popup()
	set_as_toplevel(false)		#This was a BS Problem to find. defaults true, and when true GUI was disabled
	pass

#func _process(delta):
#	print($Viewport.get_camera())
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
