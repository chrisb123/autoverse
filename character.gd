extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var grid_translation_x = 0
var grid_translation_y = 0
var grid_translation_z = 0
export var size1 = Vector3()
export var size2 = Vector3()
var flashing
var begin = 0
var end = 0
var path = []
var pp
var SPEED = 5
var m = SpatialMaterial.new()

onready var obj_map = get_node("/root/Main/ObjMap")
onready var terr_map = get_node("/root/Main/TerrMap")
onready var camera = get_node("/root/Main/Camera")

func _ready():
	end = terr_map.astr.get_closest_point(Vector3(0,0,0))


func _process(delta):	
#character is not a fixed object what is the value of all this that getting translation wont solve?

#probably not the cleanest way of doing it. but works. Character now exists on obj_map like objects.
#	if round(translation.x) != (grid_translation_x): 
##		grid_translation_x = round(translation.x)
##		if obj_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null: #The navigation system should handle this
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) #How does this suppose to function?
#	if round(translation.y) != (grid_translation_y):
##		grid_translation_y = round(translation.y)
##		if obj_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null:
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
#	if round(translation.z) != (grid_translation_z):
##		grid_translation_z = round(translation.z)
##		if obj_map._get_grid_contents(Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) == null:
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
	# as character moves it compares last grid position (grid_translation_x) of character with current rounded translation position.
	# once character reaches 0.5 towards next grid location they comparison becomes disimilar and will trigger set_grid_actor to update position
	# you commented out the the steps which writes the rounded value into grid translation for the next comparison.
	# eg at 0,0,0. character moves to (0,0,0.51) rounds up to 0,0,1 writes this into gri translation and set_grid_actor.
	# now at 0,0,1 character moves to 0,0.51,1, rounds up to 0,1,1 and sends to grid etc etc etc.
	# allows character to animate across the map, while still being part of the grid. should make it easier for determining
	# what is in grid spaces next to Actors
	
#	if round(translation.x) != (grid_translation_x): 
#		grid_translation_x = round(translation.x)
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z)) #How does this suppose to function? see above
#	if round(translation.y) != (grid_translation_y):
#		grid_translation_y = round(translation.y)
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
#	if round(translation.z) != (grid_translation_z):
#		grid_translation_z = round(translation.z)
#		obj_map._set_grid_actor(self,Vector3(grid_translation_x,grid_translation_y,grid_translation_z))
		
	if (path.size() > 1): #Can be used to move character
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
#		print(atpos.distance_to(path[path.size() - 2]))

		var t = Transform()
		t.origin = atpos
		t=t.looking_at(atpos - atdir, Vector3(0, 1, 0))
		.set_transform(t)

		if (path.size() < 2):
			path = []
			set_process(false)
	else:
		set_process(false)
			
func _obj_flash_start():
	flashing = true
	while flashing:
		visible = false
		yield(get_tree().create_timer(.25),"timeout")
		visible = true
		yield(get_tree().create_timer(.25),"timeout")

func _obj_flash_stop():
	visible = true
	flashing = false			
#		yield(get_tree(), "idle_frame")
	#print(old_translation_x," ",old_translation_y, " ",old_translation_z)

func _click(result):
	if result and path.size() < 2:
		var grid_select = camera._int_position(result.position)
		begin = end
		end = terr_map.astr.get_closest_point(grid_select)
		if grid_select != terr_map.astr.get_point_position(end):
			terr_map._gen_map(grid_select)
			end = terr_map.astr.get_closest_point(grid_select)
		if not camera.placement:
			_update_path()
		else:
				end = begin

func _update_path():
	var curve = Curve3D.new()
	var p = terr_map.astr.get_point_path(begin, end)
	path = Array(p) # Vector3array too complex to use, convert to regular array
	for i in path:
		curve.add_point(i)
	var j = curve.get_baked_points()
	path = Array(j)
	path.invert()
	if not path.size():
		end = begin
	else:
		set_process(true)
		var yoffset = Vector3(0,1,0)
		var im = get_node("../Draw") #Draw a line for visual reference, not needed in game
		m.set_albedo(Color(1,1,1))
		im.set_material_override(m)
		im.clear()
		im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
		for x in path:
			im.add_vertex(x+yoffset)
		im.end()