extends MenuButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var popup


func _ready():
	popup = get_popup()
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	print(ID, "  ", popup.get_item_text(ID))
	#Instance an object from ID and follow mouse pointer

	



