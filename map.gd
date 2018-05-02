extends GridMap

var asID = 0
var as = AStar.new()
onready var camera = get_node("/root/Main/Camera")
onready var gui = get_node("/root/Main/GUI")
var begin = 0
var end = 0
var path = []
var SPEED = 20
var mouse_active = true

func _ready():
	var a = Thread.new()
	a.start(self,"_gen_map",Vector3(0,0,0))
	a.wait_to_finish()

	
func _gen_map(pos,size=15): #How long does a grid this size take to create for you?
#	print("Starting map gen:",pos)
	for x in range(-size,size+1): 
		for y in range(-size,size+1):
			var point = pos + Vector3(x,0,y)
			if get_cell_item(point.x,point.y,point.z) == INVALID_CELL_ITEM: #if tile map cant be found then add a tile
				as.add_point(asID, point)
				set_cell_item(point.x,point.y,point.z,global.tern.GRASS)
				asID += 1 #generate point list, never alter this variable
	for x in range(-size,size+1):
		for y in range(-size,size+1):
			var point = pos + Vector3(x,0,y)
			var i = as.get_closest_point(point)
			var posa = as.get_point_position(i)
			for x in range(-1,2): #adds missing navigation links to all recently generated points
				for y in range(-1,2):
					var posb = posa + Vector3(x,0,y)
					var j = as.get_closest_point(posb)
					if i != j and not as.are_points_connected(i,j):
						as.connect_points(i,j,true) #generate connections
					
	end = as.get_closest_point(Vector3(0,0,0))
#	print("Map gen ended")

func _input(event): #This piece of code is for testing
	if event is InputEventMouseButton and gui.mouse_in_main_gui: #its alrteady handled in camera just reference the value
		if event.get_button_index() == 1 and event.is_pressed():
			var result = camera._mouse_ray(event.position)
			if result and path.size() < 2:
				var grid_select = camera._int_position(result.position)
				begin = end
				end = as.get_closest_point(grid_select)
				if grid_select != as.get_point_position(end):
					_gen_map(grid_select)
					end = as.get_closest_point(grid_select)
				if not camera.placement:
					_update_path()
				else:
					end = begin
				

func _update_path():
	var curve = Curve3D.new()
	var p = as.get_point_path(begin, end)
	path = Array(p) # Vector3array too complex to use, convert to regular array
	for i in path:
		curve.add_point(i)
	var j = curve.get_baked_points()
	path = Array(j)
	path.invert()
	if not path.size():
		end = begin
	set_process(true)
	

func _remove_point(pos):
	var id = as.get_closest_point(pos)
	if as.get_point_position(id).distance_to(pos) < 1:
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
		get_node("/root/Main/GridMap/Character").set_transform(t)
		
		if (path.size() < 2):
			path = []
			set_process(false)
	else:
		set_process(false)