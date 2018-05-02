extends Camera

const CAMSPEED = 10
var RMB = false
var ray_length = 10000
var space_state
var grid = Vector3()
var grid_select = Vector3()
signal grid_selected
var placement
onready var grid_map = get_node("/root/Main/GridMap")
onready var gui = get_node("/root/Main/GUI")
var UndockWindow = load("res://Structures/Messages/UndockWindow.tscn")
var obj_old
var mouse_pos
var mouse_active = true

func _ready():
	pass

func _process(delta):
	var pos = Vector3()
	if Input.is_action_pressed("ui_right"):
		pos.x += delta * CAMSPEED
	if Input.is_action_pressed("ui_left"):
		pos.x -= delta * CAMSPEED
	if Input.is_action_pressed("ui_fwd"):
		pos.z -= delta * CAMSPEED
	if Input.is_action_pressed("ui_back"):
		pos.z += delta * CAMSPEED
	if Input.is_action_pressed("ui_up"):
		pos.y += delta * CAMSPEED
	if Input.is_action_pressed("ui_down"):
		pos.y -= delta * CAMSPEED
	translate_object_local(pos)
	pos = get_translation()
	if pos.y < 0.1:
		pos.y = 0.1
	set_translation(pos)

func _get_grid_select():
	return grid_select

func _get_grid():
	return grid
	
func _set_placement(place): #setting placement
	placement = place

func _mouse_ray(position):
	var from = project_ray_origin(position)
	var to = from + project_ray_normal(position) * ray_length
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from,to)
	return result

func _int_position(input):
	var out = Vector3()
	out.x = round(input.x)
	out.y = round(input.y)
	out.z = round(input.z)
	return out

func _input(event):
	if event is InputEventMouseButton and gui.mouse_in_main_gui:
		if event.get_button_index() == 2 and event.is_pressed():
			RMB = true
			mouse_pos = event.position
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.get_button_index() == 2 and not event.is_pressed():
			RMB = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.warp_mouse_position(mouse_pos)
		elif event.get_button_index() == 1 and event.is_pressed() and Input.is_action_pressed("ui_select"):
			var result = _mouse_ray(event.position)
			if result:
				grid_select = _int_position(result.position)
				emit_signal("grid_selected")
				var obj = grid_map._get_grid_contents(grid_select)
				if obj:
					var window_to_add = UndockWindow.instance()
					gui.add_child(window_to_add)
					window_to_add._initialize(obj, "Shift click window")
	elif event is InputEventMouseMotion and RMB and gui.mouse_in_main_gui:
		var rot = event.get_relative()
		var camrot = get_rotation_degrees()
		camrot.y -= rot.x / CAMSPEED
		camrot.x -= rot.y / CAMSPEED
		if camrot.x > -5:
			camrot.x = -5
		elif camrot.x < -85:
			camrot.x = -85
		set_rotation_degrees(camrot)
	elif event is InputEventMouseMotion and Input.is_action_pressed("ui_select") and not placement and gui.mouse_in_main_gui:
		var result = _mouse_ray(event.position)
		if result:
			var pos = _int_position(result.position)
			var obj = grid_map._get_grid_contents(pos)
			if obj_old != obj:
				if obj_old:
					obj_old._obj_flash_stop()
					obj_old = null
				if obj:
					obj._obj_flash_start()
					obj_old = obj
	#A bit more resource intensive, but im guessing acces at all times from anywhere could be beneficial	
	#Only processes when placment is set
	elif event is InputEventMouseMotion and placement:
		var result = _mouse_ray(event.position)
		if result:
			grid = _int_position(result.position)
			
	if Input.is_action_just_released("ui_select") and obj_old:
		obj_old._obj_flash_stop()
		obj_old = null