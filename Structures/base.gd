extends Spatial

export var size1 = Vector3()
export var size2 = Vector3()
onready var grid_map = get_node("/root/Main/GridMap")
var position
var facing = Vector3()

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
	
	#Example of getting contents of grid
	position.x += size2.x + size1.x
	var obj = grid_map._get_grid_contents(position)
	if obj:
		print("The object to the right belongs to group:",obj.get_groups()) # this is physical right, but not right based upon objects facing
		print("The object ID is:",obj)
	
	#Set Facing based upon Rotation at placement
func _set_facing(rotation):
	if rotation == 0:
		facing = Vector3(1,0,0)
		print("Faces Right ", facing) #facing text is based upon camera initial position
	elif rotation == 90:
		facing = Vector3(0,0,-1)
		print("Faces up ", facing)
	elif rotation == 180:
		facing = Vector3(-1,0,0)
		print("Faces left ", facing)
	elif rotation == 270:
		facing = Vector3(0,0,1)
		print("Faces down ", facing)
		
		

