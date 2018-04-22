extends Spatial

var input_q = []
var output_q = []
var position
var put = []
var get = []
onready var grid_map = get_node("/root/Main/GridMap")

func _start():
	position = get_parent().translation
	print("Obj: The feeding arm specific script")
	put.append(position + get_parent().facing)
	get.append(position - get_parent().facing)

func _tick1():
	if input_q.size() < 1:
		for i in get:
			var j = grid_map._get_grid_contents(i)
			if j:
				input_q.push_front(j.get_node("Obj").output_q.pop_back())
	if output_q.size() > 0:
		for i in put:
			var j = grid_map._get_grid_contents(i)
			if j:
				j.get_node("Obj").input_q.push_front(output_q.pop_back())
	
func _tick2():
	output_q.push_front(input_q.pop_back())