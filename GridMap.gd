extends GridMap

# grid map should probably have x,y,z and internal ID

var grid_map = []
var height = 10
var width = 10
var depth = 2

func _ready():
	for x in range(height):
		grid_map.append([])
		for y in range(height):
			grid_map[x].append(0)

func _is_grid_empty(x,y,size): #use 'is' not 'get' for boolean requests
	if grid_map[x][y] == 0 and size == 1: #negative indexes dont work...
		return true
	elif grid_map[x][y] == 0 and grid_map[x+1][y] == 0 and grid_map[x][y-1] == 0 and grid_map[x+1][y-1] == 0 and size == 2: #terrible method
		return true
	else:
		return false

func _set_grid_contents(x,y,object_to_add,size):
	grid_map[x][y] = object_to_add
	if size == 2: #terrible implimentation
		grid_map[x+1][y] = object_to_add
		grid_map[x][y-1] = object_to_add
		grid_map[x+1][y-1] = object_to_add

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

