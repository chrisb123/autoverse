extends Navigation

onready var camera = get_node("/root/Main/Camera")
onready var character = get_node("/root/Main/Character")
var begin = Vector3()
var end = Vector3()
var path = []
var SPEED = 10

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			var result = camera._mouse_ray(event.position)
			if result:
				var grid_select = camera._int_position(result.position)
#				print(get_closest_point(grid_select)) #should print closest point, but doesnt
	
#				print(get_simple_path(start,grid_select))
				begin = end
				end = grid_select
				_update_path()
	
#	var path = get_simple_path(Vector3(-1,0,-1),Vector3(1,0,1))
#	for a in path:
#		print(a)


func _process(delta):
	if (path.size() > 1):
		var to_walk = delta*SPEED
		var to_watch = Vector3(0, 1, 0)
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		var atdir = to_watch
		atdir.y = 0
		
		var t = Transform()
		t.origin = atpos
		t=t.looking_at(atpos - atdir, Vector3(0, 1, 0))
		get_node("/root/Main/Character").set_transform(t)
		
		if (path.size() < 2):
			path = []
			set_process(false)
	else:
		set_process(false)


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector3array too complex to use, convert to regular array
	path.invert()
	set_process(true)