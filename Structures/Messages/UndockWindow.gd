extends WindowDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var camera = get_node("HBoxContainer/ViewportContainer/Viewport/TextureRect/Camera")

func _ready():
	self.popup()
	set_as_toplevel(false)		#This was a BS Problem to find. defaults true, and when true GUI was disabled
	pass
	
func _set_camera(zoomgrid):
	camera.look_at_from_position(zoomgrid + Vector3(0,3,3), zoomgrid, Vector3(0,1,0))

	

#func _process(delta):
#	print($Viewport.get_camera())
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
