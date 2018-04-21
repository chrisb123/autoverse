extends Spatial

var input_q = []
var output_q = []
var position
var put = []
var get = []

func _start():
	position = get_parent().translation
	print("Obj: The feeding arm specific script")
	put.append(position + get_parent().facing)
	get.append(position - get_parent().facing)
	