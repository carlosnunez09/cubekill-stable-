extends Control

@export var Address = "100.86.35.44"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
# Function that gets called when the button is pressed.
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass


#this gets called on the server and cleint
func PlayerConnected(id):
	print("player connected" + str(id))
	
#this gets called on the server and cleint
func PlayerDisconnected(id):
	print("player disconnected" + str(id))
#called only from clients
func connected_to_server(id):
	print("player connected to server!" + str(id))
	
#called only from clients
func connection_failed(id):
	print("player failed to connect " + id)


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

func _on_host_button_down():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port,2)
	if error != OK:
		print("canno  host: " +  error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting")
	pass # Replace with function body.




func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,port)
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.
