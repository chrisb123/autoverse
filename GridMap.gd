extends GridMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var grid_map = []
var height = 10
var width = 10
var depth = 2

func _ready():
	for x in range(height):
		grid_map.append([])
		for y in range(height):
			grid_map[x].append(0)

func _get_grid_empty(x,y):
	if grid_map[x][y] == 0:
		return true
	else:
		return false

func _set_grid_contents(x,y,object_to_add):
	grid_map[x][y] = object_to_add
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
