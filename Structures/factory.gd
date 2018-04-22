extends Spatial

var put = []
var get = []
var input_q = []
var output_q = []
var in_q_full = false

func _start():
	print("Obj: The factory specific script, Finding and linking feeders")

func _tick1():
	pass
	
func _tick2():
	if input_q.size() < 10:
		in_q_full = false
	else:
		in_q_full = true