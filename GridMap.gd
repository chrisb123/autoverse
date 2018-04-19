extends GridMap

# grid map should probably have x,y,z and internal ID

var grid_map = {}

func _ready():
	pass

func _is_grid_empty(pos,size1,size2): #use 'is' not 'get' for boolean requests
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(pos.x+x,pos.y+y,pos.z+z)
				if grid_map.has(location): 
					return false
	return true

func _set_grid_contents(object,size1,size2):
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(object.translation.x+x,object.translation.y+y,object.translation.z+z)
				grid_map[location] = object

func _get_grid_contents(pos):
	if grid_map.has(pos): 
		return grid_map[pos]
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

