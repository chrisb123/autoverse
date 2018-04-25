extends Spatial

var input_q = []
var output_q = []
var in_q_full = false
var position
var put = []
var get = []
onready var grid_map = get_node("/root/Main/GridMap")
var enabled = false

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
			if j and not j.get_node("Obj").in_q_full:
				j.get_node("Obj").input_q.push_front(output_q.pop_back())
	
func _tick2():
	if output_q.size() == 0:
		var item = input_q.pop_back()
		if item:
			output_q.push_front(item)
	if input_q.size() < 1:
		in_q_full = false
	else:
		in_q_full = true