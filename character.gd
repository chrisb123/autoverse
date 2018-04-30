extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var grid_translation_x = 0
var grid_translation_y = 0
var grid_translation_z = 0
export var size1 = Vector3()
export var size2 = Vector3()

onready var grid_map = get_node("/root/Main/GridMap")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):	#probably not the cleanest way of doing it. but works. Character now exists on Grid_Map like objects.
	if round(translation.x) != (grid_translation_x): 
		grid_translation_x = round(translation.x)
		if grid_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null:
			grid_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
	elif round(translation.y) != (grid_translation_y):
		grid_translation_y = round(translation.y)
		if grid_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null:
			grid_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
	elif round(translation.z) != (grid_translation_z):
		grid_translation_z = round(translation.z)
		if grid_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null:
			grid_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
#		yield(get_tree(), "idle_frame")
	#print(old_translation_x," ",old_translation_y, " ",old_translation_z)
