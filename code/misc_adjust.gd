extends Node


@export var PlayerScene : PackedScene

var player_id1
var player_id2
func _ready():
	
	
	

	
	player_id1 = GameManager.live_players[0]
	player_id2 = GameManager.live_players[1]
	
	spwan(player_id1)
	spwan(player_id2)
	print(GameManager.live_players[0])
	
	# Load your custom cursor image (Resource)
	var cursor_image = preload("res://char_assets/cube_hallo.png")

	# Set the custom mouse cursor with a 0, 0 offset
	set_custom_mouse_cursor(cursor_image, Input.CURSOR_ARROW, Vector2(10, 10))
	

func set_custom_mouse_cursor(image: Resource, shape: int = 0, hotspot: Vector2 = Vector2(0, 0)):
	Input.set_custom_mouse_cursor(image, shape, hotspot)


func spwan(id_num):
	var currentPlayer = PlayerScene.instantiate()
	currentPlayer.name = str(GameManager.Player[id_num].id)
	add_child(currentPlayer)
	currentPlayer.global_position + Vector2(100,100)
	
	
