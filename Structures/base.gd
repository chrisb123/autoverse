extends Spatial

export var size1 = Vector3()
export var size2 = Vector3()
onready var grid_map = get_node("/root/Main/GridMap")
var position
var facing = Vector3()
var up = Vector3(0,1,0)
var obj
var flashing
var timer = 0
var enabled = false
signal destroy

func _start():
	position = translation
	print("Base: The generic object script")
	get_node("Obj")._start()
	
func _process(delta):
	timer += delta
	if timer > 0.5:
		if enabled:
			$Obj._tick2()
		$Obj._tick1()
		timer = 0

	#Set Facing based upon Rotation at placement
func _set_facing(rotation):
	if rotation == 0:
		facing = Vector3(1,0,0)
		print("Faces Right ", facing) #facing text is based upon camera initial position
	elif rotation == 90:
		facing = Vector3(0,0,-1)
		print("Faces up ", facing)
	elif rotation == 180:
		facing = Vector3(-1,0,0)
		print("Faces left ", facing)
	elif rotation == 270:
		facing = Vector3(0,0,1)
		print("Faces down ", facing)

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

func destroy():
	emit_signal("destroy",self)
	queue_free()
