extends Spatial

export var size1 = Vector3()
export var size2 = Vector3()
onready var grid_map = get_node("/root/Main/GridMap")
var position
var facing = Vector3()
var up = Vector3(0,1,0)
var parents = []
var children = []
var input_q
var output_q
var obj

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _add_parent(obj):
	if parents.has(obj):
		parents.erase(obj)
	parents.append(obj)
	print("Object added as parent:",obj," Parents:",parents)

func _add_child(obj):
	if children.has(obj):
		children.erase(obj)
	children.append(obj)
	print("Object added as child:",obj, " Children:", children)


func _start():
	position = translation
	print("Base: The generic object script")
	if self.is_in_group("belt") or self.is_in_group("feed"):
		_link_fb()
	if self.is_in_group("belt"):
		_link_lr()

func _link_fb():
	obj = grid_map._get_grid_contents(translation + facing)
	if obj:
		print("The object in FRONT of me belongs to group:",obj.get_groups()) # this is physical right, but not right based upon objects facing
		print("The object ID is:",obj)
		children.append(obj) #add child to children
		obj._add_parent(self) #add self as parent to child

	obj = grid_map._get_grid_contents(translation - facing)
	if obj:
		print("The object BEHIND me belongs to group:",obj.get_groups()) # this is physical right, but not right based upon objects facing
		print("The object ID is:",obj)
		parents.append(obj) #add parents to parent
		obj._add_child(self) #add self as child to parent

func _link_lr():
	var facing_temp = facing.rotated(up,deg2rad(90))
	obj = grid_map._get_grid_contents(translation + facing)
	if obj:
		print("The object to LEFT me belongs to group:",obj.get_groups()) # this is physical right, but not right based upon objects facing
		print("The object ID is:",obj)
		obj._add_parent(self) #add self as parent to child
	
	facing_temp = facing.rotated(up,deg2rad(-90))
	obj = grid_map._get_grid_contents(translation + facing)
	if obj:
		print("The object to RIGHT me belongs to group:",obj.get_groups()) # this is physical right, but not right based upon objects facing
		print("The object ID is:",obj)
		obj._add_parent(self) #add self as parent to child


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


func _obj_flash_start():
	print("Start object flash:",self)
	
func _obj_flash_stop():
	print("Stop object flash:",self)
