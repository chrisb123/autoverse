extends Spatial

var input_node #node that feeds this belt
var output_node #node to send contents too
var output_data #input stuff
var input_data #output stuff

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _start():
	print("Obj: The belt specific script")
	
#use rotation to find this belts inpuit and output
#example of how belts could work
#have a loop that basically feeds itelf
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