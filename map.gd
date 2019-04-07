extends GridMap

var asID = 0
var astr = AStar.new()
onready var camera = get_node("/root/Main/Camera")
onready var gui = get_node("/root/Main/GUI")

#var _state = null
#enum STATES { IDLE, FOLLOW }
#var target_point_world = Vector2()

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
				astr.add_point(asID, point)
				set_cell_item(point.x,point.y,point.z,global.tern.GRASS)
				asID += 1 #generate point list, never alter this variable
	for x in range(-size,size+1):
		for y in range(-size,size+1):
			var point = pos + Vector3(x,0,y)
			var i = astr.get_closest_point(point)
			var posa = astr.get_point_position(i)
			for x in range(-1,2): #adds missing navigation links to all recently generated points
				for y in range(-1,2):
					var posb = posa + Vector3(x,0,y)
					var j = astr.get_closest_point(posb)
					if i != j and not astr.are_points_connected(i,j):
						astr.connect_points(i,j,true) #generate connections
					
#	get_node("/root/Main/CharMap/Character").end = as.get_closest_point(Vector3(0,0,0))
#	print("Map gen ended")

func _input(event): #This piece of code is for testing charcter movement
	if event is InputEventMouseButton and gui.mouse_in_main_gui and not Input.is_action_pressed("ui_select") and not camera.placement: #its alrteady handled in camera just reference the value
		if event.get_button_index() == 1 and event.is_pressed():
			var result = camera._mouse_ray(event.position)
			get_node("/root/Main/CharMap/Character")._click(result) #For testing dont use _click or result
			
				

func _remove_point(pos):
	var id = astr.get_closest_point(pos)
	if astr.get_point_position(id).distance_to(pos) < 1:
		var con = astr.get_point_connections(id)
		for i in con:
			astr.disconnect_points(id,i) #remove connections
		astr.remove_point(id) #remove point
