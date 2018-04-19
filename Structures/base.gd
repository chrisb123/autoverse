extends Spatial

export var size1 = Vector3()
export var size2 = Vector3()
onready var grid_map = get_node("/root/Main/GridMap")
var position

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _start():
	position = translation
	print("Base: The generic object script")
	position.x += size2.x + size1.x
	var obj = grid_map._get_grid_contents(position)
	if obj:
		print("The object to the right belongs to group:",obj.get_groups())
		print("The object ID is:",obj)
	