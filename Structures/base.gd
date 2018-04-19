extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var size1 = Vector3()
export var size2 = Vector3()


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _get_size1():
	return size1
func _get_size2():
	return size2
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
