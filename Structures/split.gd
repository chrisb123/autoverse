extends Spatial

var input_q = []
var output_q = []
var position
var put = []
var get = []

func _start():
	position = get_parent().translation
	print("Obj: The splitter specific script")
	put.append(position + get_parent().facing)

func _tick1():
	pass
	
func _tick2():
	pass