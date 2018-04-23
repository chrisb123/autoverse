extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var popup_was_visible
onready var time_to_die = get_parent().get_parent().get_node("Time_To_Die")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _initialize(longtext):
	if longtext == null: #use null not an empty string
		self.hide()
	else:
		self.show()
		$PopupDialog/Label.text = longtext	

func _process(delta):
	if self.pressed:
		$PopupDialog.popup()
		time_to_die.set_paused(true)
		popup_was_visible = true
	if $PopupDialog.visible == false && popup_was_visible:
		time_to_die.set_paused(false)
		popup_was_visible = false
		
		
#	pass
