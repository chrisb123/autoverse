extends Navigation

onready var camera = get_node("/root/Main/Camera")

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			var result = camera._mouse_ray(event.position)
			if result:
				var grid_select = camera._int_position(result.position)
				print(grid_select)
				print(get_closest_point(grid_select)) #should print closest point, but doesnt
	
#	print(get_simple_path(Vector3(-10,1,-10),Vector3(10,0,10)))
	
	var path = get_simple_path(Vector3(-1,0,-1),Vector3(1,0,1))
	for a in path:
		print(a)