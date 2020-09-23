extends Node

onready var camera = get_node("/root/Main/Camera")
onready var obj_map = get_node("/root/Main/ObjMap")
onready var char_map = get_node("/root/Main/CharMap")
var character = load("res://character.tscn")

func _ready():
	camera.connect("grid_selected",self,"_grid_selected")
	var tmp = character.instance()
	char_map.add_child(tmp)
#	_tick_loop()

func _process(delta):
	
	$DirectionalLight.rotation_degrees.x -= delta
	if $DirectionalLight.rotation_degrees.x < 0:
		$DirectionalLight.rotation_degrees.x = 360


#func _tick_loop():
#	while true:
#		for i in obj_map.get_children():
#			if ! i.is_in_group("Actor"):
#				i.get_node("Obj")._tick1()
#		yield(get_tree().create_timer(.5),"timeout")
#		for i in obj_map.get_children():
#			if ! i.is_in_group("Actor"):
#				i.get_node("Obj")._tick2()
#		yield(get_tree().create_timer(.5),"timeout")

func _grid_selected():
	var pos = camera._get_grid_select()
	print("----- GRID Contents -----")
	print("Selcted grid:",pos)
	print("Selected ID:",obj_map._get_grid_contents(pos))
	var obj = obj_map._get_grid_contents(pos)
	if obj:
		if ! obj.is_in_group("Actor"):
			print("Input Queue",obj.get_node("Obj").input_q)
			print("Output Queue",obj.get_node("Obj").output_q)
			print("Group:",obj.get_groups())
			for i in obj.get_node("Obj").put:
				var j = obj_map._get_grid_contents(i)
				if j:
					print("Put:",j,j.get_groups())
			for i in obj.get_node("Obj").get:
				var j = obj_map._get_grid_contents(i)
				if j:
					print("Get:",j,j.get_groups())
