extends GridMap

# grid map should probably have x,y,z and internal ID

onready var map = get_node("/root/Main/TerrMap")
var obj_map = {}


func _is_grid_full(obj, size1 = null, size2 = null): #now optionally returns id of location and optional size parameters
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
				if obj_map.has(location):
					return obj_map[location]
				for i in get_node("/root/Main/CharMap").get_children(): #just walk through the character nodes and check location
					if i.is_in_group("Actor") and location == i.translation:
						 return i
	return false

func _set_grid_contents(object):
	var size1 = object.size1
	var size2 = object.size2
	size2 = size2 + size1
	for x in range(size1.x,size2.x):
		for y in range(size1.y,size2.y):
			for z in range(size1.z,size2.z):
				var location = Vector3(object.translation.x+x,object.translation.y+y,object.translation.z+z)
				obj_map[location] = object
				map._remove_point(location)

func _get_grid_contents(pos):
	if obj_map.has(pos): 
		return obj_map[pos]
	for i in get_node("/root/Main/CharMap").get_children(): #just walk through the character nodes and check location
		if i.is_in_group("Actor") and pos == i.translation:
			 return i

# The character class has its position
#func _set_grid_actor(actor,grid_location):
#
#	#Delete any obj_map locations of actor. eg. previous location of Actor.
#	while obj_map.values().has(actor):
#		var temp = obj_map.values().find(actor)
#		var temp2 = obj_map.keys()[temp]
#		obj_map.erase(temp2)
#
#	#Add new position of Actor. 
#	var size1 = actor.size1
#	var size2 = actor.size2
#	size2 = size2 + size1
#	for x in range(size1.x,size2.x):
#		for y in range(size1.y,size2.y):
#			for z in range(size1.z,size2.z):
#				var location = Vector3(grid_location.x+x,grid_location.y+y,grid_location.z+z)
#				obj_map[location] = actor
##	print(obj_map)
#
#func _get_actor_grid(actor):
#		var temp = obj_map.values().find(actor)
#		return obj_map.keys()[temp]
	#Add new position of Actor. 
#	var size1 = actor.size1
#	var size2 = actor.size2
#	size2 = size2 + size1
#	for x in range(size1.x,size2.x):
#		for y in range(size1.y,size2.y):
#			for z in range(size1.z,size2.z):
#				var location = Vector3(grid_location.x+x,grid_location.y+y,grid_location.z+z)
#				obj_map[location] = actor
#				print("Charactor Position: ",grid_location)
##	print(obj_map)
#
#func _get_actor_grid(actor):
#		var temp = obj_map.values().find(actor)
#		return obj_map.keys()[temp]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

