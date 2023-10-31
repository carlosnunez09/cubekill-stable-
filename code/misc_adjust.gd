extends Node

func _ready():
	# Load your custom cursor image (Resource)
	var cursor_image = preload("res://char_assets/cube_hallo.png")

	# Set the custom mouse cursor with a 0, 0 offset
	set_custom_mouse_cursor(cursor_image, Input.CURSOR_ARROW, Vector2(10, 10))

func set_custom_mouse_cursor(image: Resource, shape: int = 0, hotspot: Vector2 = Vector2(0, 0)):
	Input.set_custom_mouse_cursor(image, shape, hotspot)
