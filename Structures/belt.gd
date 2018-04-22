extends Spatial

var input_q = []
var output_q = []
var in_q_full = false
var position
var put = []
var get = []
onready var grid_map = get_node("/root/Main/GridMap")

func _start():
	position = get_parent().translation
	print("Obj: The belt specific script")
	put.append(position + get_parent().facing)

func _tick1():
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
	if input_q.size() == 0: #Can be fed from 3 sides
		in_q_full = false
	else:
		in_q_full = true

"""
Method 2, a big problem with the exisiting parent/child link plan is the requirment to link everything 
and the need to process links accounting for arbitrary order of placment. I suggest the following:
1. Remove all the links
2. Feeders have a put and get grid locations
3. Belts have a put location
4. Factories/mines  have nothing

	ABOVE AGREED

Process goes like this
Mine just accumlates resources into its inventory
Factory processes inventory and accumulates products in its inventory
Feeder gets inventory from a grid location which can be any of the mine/factory/belt etc
Belts and feeder puts inventory into whatever is at the put location, factory belt etc
Belts dont need to get as feeders and belts feed belts
That should simplify the process, still need to layout arbitrary structures correctly into the gridmap
Special case items like splitters just have multiple put or get etc as needed

	ABOVE AGREED
	
the onlz hard to do thing is when the factory is full of raw resources. the belt will completelzy fill up.
Once factory accepts new resoures, the belts will restart but in a staggered process as each needs to ensure
the next is empty before giving the items. assuming the next conveyor will pass on its inventory therefor have free space is
also not a given. if the factory is full the feeder that "should" have passed its inventory doesnt, thereby screwing up the
previous conveyors move order that assumed the feeder will pass on its contents.


"""

