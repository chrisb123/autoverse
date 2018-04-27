extends MeshInstance

var map = {}
var asID = 0
var as = AStar.new()
onready var camera = get_node("/root/Main/Camera")
onready var character = get_node("/root/Main/Character")
var begin = 0
var end = 0
var path = []
var SPEED = 10

func _ready():
	for x in range(-5,6):
		for y in range(-5,6):
			map[Vector3(x,0,y)] = asID
			as.add_point(asID, Vector3(x,0,y))
			asID += 1 #generate point list
	for i in as.get_available_point_id():
		var posa = as.get_point_position(i)
		for x in range(-1,2):
			for y in range(-1,2):
				var posb = posa + Vector3(x,0,y)
				var j = as.get_closest_point(posb)
				as.connect_points(i,j,true) #generate connections

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			var result = camera._mouse_ray(event.position)
			if result:
				var grid_select = camera._int_position(result.position)
				print(grid_select)
				begin = end
				end = as.get_closest_point(grid_select)
				_update_path()

func _update_path():
	var p = as.get_point_path(begin, end)
	path = Array(p) # Vector3array too complex to use, convert to regular array
	path.invert()
	set_process(true)

func _remove_point(pos):
	var id = as.get_closest_point(pos)
	var con = as.get_point_connections(id)
	for i in con:
		as.disconnect_points(id,i) #remove connections
	as.remove_point(id) #remove point

func _process(delta): #This has been copied from another demo program, it also should belong in the character node
	if (path.size() > 1): #its probably good enough to use, change it as needed
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