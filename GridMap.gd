extends GridMap

# grid map should probably have internal ID

var size_x = 10		#1 or Even number only so (0,0,0) grid is in dead centre array
var size_y = 1		#1 or Even number only so (0,0,0) grid is in dead centre array
var size_z = 10		#1 or Even number only so (0,0,0) grid is in dead centre array
var grid_map = []
var gridoffset_x = 0
var gridoffset_y = 0
var gridoffset_z = 0

var local_x
var local_y
var local_z


func _ready():
	for x in range(size_x):
		grid_map.append([])
		for y in range(size_y):
			grid_map[x].append([])
			for z in range(size_z):
				grid_map[x][y].append(0)	
	#print(grid_map) #For testing only, outuput window gets pissy when its really big

	#offset to get (0,0,0) in grid map to dead centre Array
	#all gridreferences offset by these amounts to ensure all grid array interactions are with postive numbers	
	if size_x > 1:
		gridoffset_x = size_x / 2
	if size_y > 1:
		gridoffset_y = size_x / 2
	if size_z > 1:
		gridoffset_z = size_x / 2
		
func _offset_grid_to_array(x,y,z):
	print("--- Grid Ref ---")
	print(x," ",y," ",z)
	local_x = x + gridoffset_x
	local_y = y + gridoffset_y
	local_z = z + gridoffset_z
	print("--- After Offset ---")
	print(local_x," ",local_y," ",local_z)
	return #simple return x y z not working, therefore local_ variabls for x y z

func _is_grid_empty(x,y,z,size):
	_offset_grid_to_array(x,y,z)
	print("--- Grid Check ---")
	print(local_x," ",local_y," ",local_z)
	if grid_map[local_x][local_y][local_z] == 0 and size == 1: #negative indexes dont work...
		return true
	elif grid_map[local_x][local_y][local_z] == 0 and grid_map[local_x+1][local_y][local_z] == 0 and grid_map[local_x][local_y][local_z-1] == 0 and grid_map[local_x+1][local_y][local_z-1] == 0 and size == 2: #terrible method
		return true
	else:
		return false

func _set_grid_contents(x,y,z,object_to_add,size):
	_offset_grid_to_array(x,y,z)
	print("--- Add to Grid ---")
	print(local_x," ",local_y," ",local_z)
	grid_map[local_x][local_y][local_z] = object_to_add
	if size == 2: #terrible implimentation
		grid_map[local_x+1][local_y][local_z] = object_to_add
		grid_map[local_x][local_y][local_z-1] = object_to_add
		grid_map[local_x+1][local_y][local_z-1] = object_to_add

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

