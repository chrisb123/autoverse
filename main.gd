extends Node

onready var camera = get_node("/root/Main/Camera")

func _ready():
	camera.connect("grid_set",self,"grid_set")

#func _process(delta):
#	pass

func grid_set():
	print ("put a marker here",camera.get_grid())
	