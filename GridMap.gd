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

func _is_grid_empty(pos,size): #use 'is' not 'get' for boolean requests
	if grid_map.has(pos): #negative indexes dont work...
		return false
	else:
		return true

func _set_grid_contents(pos,object_to_add,size):
	grid_map[pos] = object_to_add


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

