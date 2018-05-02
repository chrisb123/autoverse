extends GridMap

# grid map should probably have x,y,z and internal ID

onready var map = get_node("/root/Main/TerrMap")
var grid_map = {}

func _ready():
	pass

func _is_grid_empty(obj, contents = false, size1 = null, size2 = null): #now optionally returns id of location and optional size parameters
	var pos = obj.translation
	if not size1:
		size1 = obj.size1
	if not  size2:
		size2 = obj.size2
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(pos.x+x,pos.y+y,pos.z+z)
				if grid_map.has(location):
					if contents:
						return grid_map[location]
					else: 
						return false
	return true

func _set_grid_contents(object):
	var size1 = object.size1
	var size2 = object.size2
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(object.translation.x+x,object.translation.y+y,object.translation.z+z)
				grid_map[location] = object
				map._remove_point(location)

func _get_grid_contents(pos):
	if grid_map.has(pos): 
		return grid_map[pos]
		
func _set_grid_actor(actor,grid_location):
	
	#Delete any Grid_Map locations of actor. eg. previous location of Actor.
	while grid_map.values().has(actor):
		var temp = grid_map.values().find(actor)
		var temp2 = grid_map.keys()[temp]
		grid_map.erase(temp2)

	#Add new position of Actor. 
	var size1 = actor.size1
	var size2 = actor.size2
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(grid_location.x+x,grid_location.y+y,grid_location.z+z)
				grid_map[location] = actor
#	print(grid_map)

func _get_actor_grid(actor):
		var temp = grid_map.values().find(actor)
		return grid_map.keys()[temp]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

