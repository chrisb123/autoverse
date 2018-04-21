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
		for i in obj.get_node("Obj").put:
			var j = grid_map._get_grid_contents(i)
			print("Put:",j,j.get_groups())
		for i in obj.get_node("Obj").get:
			var j = grid_map._get_grid_contents(i)
			print("Get:",j,j.get_groups())