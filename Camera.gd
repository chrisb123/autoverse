extends Camera

const CAMSPEED = 10
var RMB = false
var ray_length = 10000
var space_state
var grid = Vector3()
var grid_select = Vector3()
signal grid_selected
var placement

func _ready():
	pass

func _process(delta):
	var pos = Vector3()
	if Input.is_action_pressed("ui_right"):
		pos.x += delta * CAMSPEED
	elif Input.is_action_pressed("ui_left"):
		pos.x -= delta * CAMSPEED
	elif Input.is_action_pressed("ui_fwd"):
		pos.z -= delta * CAMSPEED
	elif Input.is_action_pressed("ui_back"):
		pos.z += delta * CAMSPEED
	elif Input.is_action_pressed("ui_up"):
		pos.y += delta * CAMSPEED
	elif Input.is_action_pressed("ui_down"):
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
	out.x = int(input.x)
	out.y = int(input.y)
	out.z = int(input.z)
	return out

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 2 and event.is_pressed():
			RMB = true
		elif event.get_button_index() == 2 and not event.is_pressed():
			RMB = false
		elif event.get_button_index() == 1 and event.is_pressed() and Input.is_action_pressed("ui_select"):
			var result = _mouse_ray(event.position)
			if result:
				grid_select = _int_position(result.position)
				emit_signal("grid_selected")
	elif event is InputEventMouseMotion and RMB:
		var rot = event.get_relative()
		var camrot = get_rotation_degrees()
		camrot.y -= rot.x / CAMSPEED
		camrot.x -= rot.y / CAMSPEED
		if camrot.x > -5:
			camrot.x = -5
		elif camrot.x < -85:
			camrot.x = -85
		set_rotation_degrees(camrot)
	
	#A bit more resource intensive, but im guessing acces at all times from anywhere could be beneficial	
	#Only processes when placment is set
	elif event is InputEventMouseMotion and placement:
		var result = _mouse_ray(event.position)
		if result:
			grid = _int_position(result.position)
