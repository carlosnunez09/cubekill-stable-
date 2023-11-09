extends Control

var player1_id
var player2_id
var waiting = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_setItems()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if( !multiplayer.get_peers().size() > 1 || waiting):
		_setItems()
	pass


func _setItems():
	var players_size = multiplayer.get_peers().size()
	var player2_late = multiplayer.get_peers()
	if(players_size > 1):
		player2_id = player2_late[players_size -1]
		print(player2_id)
	else:
		waiting = true
		print("wait")
		
	
		
	#var test = multiplayer.count(multiplayer.get_peers())
	
	
	
	
	
	var label2 = $player1/Label2
	var label1 = $player2/Label3
	
	player1_id = multiplayer.get_unique_id()
	
	label2.text = GameManager.Player[player1_id].name
	
	if(players_size > 1):
		label1.text = GameManager.Player[player2_id].name
	
	GameManager.live_players = [player1_id,player2_id]
	print(GameManager.live_players)
	
	#the i will establish a code/channel to send information on
	#print(label1)
	pass
@rpc("any_peer","call_local")
func start():
	var scean = load("res://scean/main_tester.tscn").instantiate()
	get_tree().root.add_child(scean)
	self.hide()
	
	



func _on_button_button_down():
	start.rpc_id(player2_id)
	start.rpc_id(multiplayer.get_unique_id())
	pass

