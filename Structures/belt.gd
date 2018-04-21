extends Spatial

var input_q = []
var output_q = []
var position
var put = []
var get = []

func _start():
	position = get_parent().translation
	print("Obj: The belt specific script")
	put.append(position + get_parent().facing)

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


# 1,2,3 below is for a constant flow of material and is basically how i was considering doing it, however i would add  
# a local inventory variable.  input -> inventory -> Output
# it needs to be checked if an invetory can be given to next Factory/Conveyor or if there is even something to give it to, otherwise it has
# to hold object in invetory and when it cant give move its invetory to next conveyor it needs to tell previous conveyor 
# it cannot accept what its trying to give. all the way back to the end of the chain.
# this is the really tricky part
	
#use rotation to find this belts inpuit and output
#example of how belts could work
#have a loop that basically feeds itelf
	#If Output block is Factory, Box, Conveyor AND accepts Resource type AND Output inventory is not full 
#1. send output_data to output_node: belt,factory
#wait
#2. transfer input_data to output_data
#wait
#3. repeat

""" no idea how if itll work
func _loop()
	loop forever:
		func child_node._txfr_data(output_data)
		sleep
		output_data = input_data
		sleep

func _txfr_data(data):
	input_data = data
"""