extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	var button =   get_parent().get_node("Button")
	#button.pressed.connect(self._button_pressed)
	print(button)
# Function that gets called when the button is pressed.
func _button_pressed():
	print("Hello world!")
