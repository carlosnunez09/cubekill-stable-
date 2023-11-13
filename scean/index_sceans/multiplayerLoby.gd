extends Control

var player1_id
var player2_id
var waiting = false
var flush = false 

func _ready():
	_setItems()
	pass 

func _process(delta):
	if multiplayer.get_peers().size() <= 1 or waiting:
		_setItems()
	pass

func _setItems():
	var peers = multiplayer.get_peers()

	player1_id = multiplayer.get_unique_id()
	player2_id = null
	waiting = true

	for id in peers:
		if id != player1_id and GameManager.Player.has(id) and GameManager.Player[id].in_game == 0:
			player2_id = id
			waiting = false
			break

	update_labels()

	GameManager.live_players = [player1_id, player2_id] if player2_id != null else [player1_id]


	flush = true
	pass

func update_labels():
	var label2 = $player1/Label2
	var label1 = $player2/Label3

	if player1_id in GameManager.Player:
		label2.text = GameManager.Player[player1_id].name
	if player2_id in GameManager.Player:
		label1.text = GameManager.Player[player2_id].name

@rpc("any_peer","call_local")
func start():
	var scene = load("res://scean/main_tester.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func _on_button_button_down():
	start.rpc_id(player2_id)
	start.rpc_id(multiplayer.get_unique_id())
	pass
