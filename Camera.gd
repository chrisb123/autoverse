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
	if pos.y < 0:
		pos.y = 0
	set_translation(pos)

func get_grid_select():
	return grid_select

func get_grid():
	return grid
	
func set_placement(place):
	placement = place

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 2 and event.is_pressed():
			RMB = true
		elif event.get_button_index() == 2 and not event.is_pressed():
			RMB = false
		elif event.get_button_index() == 1 and event.is_pressed() and Input.is_action_pressed("ui_select"):
			var from = project_ray_origin(event.position)
			var to = from + project_ray_normal(event.position) * ray_length
			var space_state = get_world().direct_space_state
			var result = space_state.intersect_ray(from,to)
			if result:
				grid_select.x = int(result.position.x)
				grid_select.y = int(result.position.y)
				grid_select.z = int(result.position.z)
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
	elif event is InputEventMouseMotion and placement:
		var from = project_ray_origin(event.position)
		var to = from + project_ray_normal(event.position) * ray_length
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(from,to)
		if result:
			grid.x = int(result.position.x)
			grid.z = int(result.position.z)
			print(grid)
