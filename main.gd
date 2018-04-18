extends Node

onready var camera = get_node("/root/Main/Camera")

func _ready():
	camera.connect("grid_selected",self,"_grid_selected")

#func _process(delta):
#	pass

func _grid_selected():
	print ("Selcted grid:",camera._get_grid_select())