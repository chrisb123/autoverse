extends GridMap

# grid map should probably have x,y,z and internal ID

var grid_map = {}
var height = 10
var width = 10
var depth = 2

func _ready():
	pass
#	for x in range(height):
#		grid_map.append([])
#		for y in range(height):
#			grid_map[x].append(0)

func _is_grid_empty(pos,size1,size2): #use 'is' not 'get' for boolean requests
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(pos.x+x,pos.y+y,pos.z+z)
				if grid_map.has(location): 
					return false
	return true

func _set_grid_contents(object,size1,size2):
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(object.translation.x+x,object.translation.y+y,object.translation.z+z)
				grid_map[location] = object

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

