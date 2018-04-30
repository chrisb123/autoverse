extends Node

onready var camera = get_node("/root/Main/Camera")
onready var grid_map = get_node("/root/Main/GridMap")
var character = load("res://character.tscn")

func _ready():
	camera.connect("grid_selected",self,"_grid_selected")
	var tmp = character.instance()
	grid_map.add_child(tmp)
	_tick_loop()

func _tick_loop():
	while true:
		for i in grid_map.get_children():
			if ! i.is_in_group("Actor"):
				i.get_node("Obj")._tick1()
		yield(get_tree().create_timer(.5),"timeout")
		for i in grid_map.get_children():
			if ! i.is_in_group("Actor"):
				i.get_node("Obj")._tick2()
		yield(get_tree().create_timer(.5),"timeout")

func _grid_selected():
	var pos = camera._get_grid_select()
	print("----- GRID Contents -----")
	print("Selcted grid:",pos)
	print("Selected ID:",grid_map._get_grid_contents(pos))
	var obj = grid_map._get_grid_contents(pos)
	if obj:
		print("Input Queue",obj.get_node("Obj").input_q)
		print("Output Queue",obj.get_node("Obj").output_q)
		print("Group:",obj.get_groups())
		for i in obj.get_node("Obj").put:
			var j = grid_map._get_grid_contents(i)
			if j:
				print("Put:",j,j.get_groups())
		for i in obj.get_node("Obj").get:
			var j = grid_map._get_grid_contents(i)
			if j:
				print("Get:",j,j.get_groups())