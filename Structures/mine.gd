extends Spatial

var input_q = []
var output_q = []
var out_q_full = false
var put = []
var get = []
var resource

func _ready():
	var i = randi()%2
	match i:
		0: resource = global.items.COAL
		1: resource = global.items.IRON

func _start():
	print("Obj: The mining specific script")


func _tick1():
	pass
	
func _tick2():
	if output_q.size() < 100:
		out_q_full = false
		output_q.push_front(resource)
	else:
		out_q_full = true