extends Camera

var pos = Vector3(0,5,8)
const CAMSPEED = 10

func _ready():
	pass

func _process(delta):
	var x = pos.x
	if Input.is_action_pressed("ui_right"):
		pos.x += delta * CAMSPEED
	if Input.is_action_pressed("ui_left"):
		pos.x -= delta * CAMSPEED
	if Input.is_action_pressed("ui_up"):
		pos.y += delta * CAMSPEED
	if Input.is_action_pressed("ui_down"):
		pos.y -= delta * CAMSPEED
	if Input.is_action_pressed("ui_fwd"):
		pos.z -= delta * CAMSPEED
	if Input.is_action_pressed("ui_back"):
		pos.z += delta * CAMSPEED
	set_translation(pos)
