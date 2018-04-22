extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var camera = get_tree().get_root().get_node("/root//Main/Camera")
var zoomgrid_local

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _initialize(zoomgrid):
	if zoomgrid == null:
		self.hide()
	else:
		self.show()
		zoomgrid_local = zoomgrid
		

func _pressed():
	camera.look_at_from_position(zoomgrid_local + Vector3(0,5,5), zoomgrid_local, Vector3(0,1,0))
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
