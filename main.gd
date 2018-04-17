extends Node

onready var camera = get_node("/root/Main/Camera")

func _ready():
	camera.connect("grid_selected",self,"grid_selected")

#func _process(delta):
#	pass

func grid_selected():
	print ("Selcted grid:",camera.get_grid_select())
	