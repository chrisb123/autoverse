extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var camera = get_tree().get_root().get_node("/root//Main/Camera")
var object_id_local

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _initialize(object_id):
	if object_id == null:
		self.hide()
	else:
		self.show()
		object_id_local = object_id
		

func _pressed():
	camera.look_at_from_position(object_id_local.translation + Vector3(0,5,5), object_id_local.translation, Vector3(0,1,0))
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
