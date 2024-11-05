extends Node2D

@export var Address = "20.5.136.143"
@export var port = 8910  
var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func PlayerConnected(id):
	print("Player connected: " + str(id))
	#sendPlayerInformation.rpc_id(1,$name.text, multiplayer.get_unique_id())

func PlayerDisconnected(id):
	print("Player disconnected: " + str(id))

func connected_to_server():
	print("Successfully connected to the server!")

func connection_failed():
	print("Failed to connect to the server.")





@rpc("any_peer")
func receive_message(message):
	var my_id = get_tree().get_multiplayer().get_unique_id()
	print( message)



@rpc("any_peer")
func send_message(message):
	var my_id = get_tree().get_multiplayer().get_unique_id()
	var full_message = message
	rpc_id(1, "receive_message", full_message)  # Send to server (assuming server ID is 1)



func joinServer():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	print("Joined server")



func _on_start_pressed():
	send_message($Inline.text)
	print("ping")
	pass # Replace with function body.



func _on_send_pressed():
	joinServer()
	pass # Replace with function body.

@rpc("any_peer")
func StartGame():
	print("🚀- gamestarted")

	
	pass

func _on_start_button_down():
	StartGame.rpc()
	pass

# i would like to make a button that
# enters a play ground to test how the players will be spownd
