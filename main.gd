extends Node

onready var camera = get_node("/root/Main/Camera")
onready var grid_map = get_node("/root/Main/GridMap")

func _ready():
	camera.connect("grid_selected",self,"_grid_selected")

#func _process(delta):
#	pass

func _grid_selected():
	var pos = camera._get_grid_select()
	print("----- GRID Contents -----")
	print("Selcted grid:",pos)
	print("Selected ID:",grid_map._get_grid_contents(pos))
	var obj = grid_map._get_grid_contents(pos)
	if obj:
		print("Group:",obj.get_groups())
		for i in obj.parents:
			print("Parents:",i,i.get_groups())
		for i in obj.children:
			print("Children:",i,i.get_groups())