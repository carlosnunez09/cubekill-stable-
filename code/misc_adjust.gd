extends Node


@export var PlayerScene : PackedScene


func _ready():
	var index = 0
	for i in GameManager.Player:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Player[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("playerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position + spawn.global_position
			index +=1
	
	
	
	
	# Load your custom cursor image (Resource)
	var cursor_image = preload("res://char_assets/cube_hallo.png")

	# Set the custom mouse cursor with a 0, 0 offset
	set_custom_mouse_cursor(cursor_image, Input.CURSOR_ARROW, Vector2(10, 10))
	

func set_custom_mouse_cursor(image: Resource, shape: int = 0, hotspot: Vector2 = Vector2(0, 0)):
	Input.set_custom_mouse_cursor(image, shape, hotspot)
