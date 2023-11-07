extends Control

@export var Address = "172.31.16.203"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
# Function that gets called when the button is pressed.
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		hostGame()
	
	pass


#peer connected
func PlayerConnected(id):
	print("player connected" + str(id))
	sendPlayerInformation.rpc_id(1,$name.text, multiplayer.get_unique_id())

	
#peer connected
func PlayerDisconnected(id):
	print("player disconnected" + str(id))
#called only from clients
func connected_to_server(id):
	print("player connected to server!" + str(id))
	
	
	
#called only from clients
func connection_failed(id):
	print("player failed to connect " + id)

@rpc("any_peer")
func sendPlayerInformation(name, id):
	if!GameManager.Player.has(id):
		GameManager.Player[id] = {
			"name" : name,
			"id" : id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.Player:
			sendPlayerInformation.rpc(GameManager.Player[i].name,i)



@rpc("any_peer","call_local")
func StartGame():
	var scean = load("res://scean/main_tester.tscn").instantiate()
	get_tree().root.add_child(scean)
	self.hide()
	pass

func _on_start_button_down():
	StartGame.rpc()
	pass
	
	
	
	
#compress_fastLZ
func hostGame():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port,4)
	if error != OK:
		print("canno  host: " +  str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting")
	#sendPlayerInformation($name.text,multiplayer.get_unique_id())

func _on_host_button_down():
	hostGame()
	sendPlayerInformation($name.text,multiplayer.get_unique_id())
	pass # Replace with function body.




func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,port)
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.
