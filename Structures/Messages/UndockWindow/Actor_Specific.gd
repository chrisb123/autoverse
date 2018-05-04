extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _set_labels(object_id,text):
	#only examples
	$Label.text = str("Character: ",text)
	$Label2.text = str("Name: ",object_id)
	$Label3.text = str("Grid Loc: ",object_id.translation)
	$Label4.text = str("Group Name: ",object_id.get_groups())
	#set_process(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
