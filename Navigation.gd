extends Navigation

onready var camera = get_node("/root/Main/Camera")

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.get_button_index() == 1 and event.is_pressed():
#			var result = camera._mouse_ray(event.position)
#			if result:
#				var grid_select = camera._int_position(result.position)
#				print(grid_select)
#				print(get_closest_point(grid_select)) #should print closest point, but doesnt