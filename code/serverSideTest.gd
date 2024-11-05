extends Node

@export var Address = "20.5.136.143"
@export var port = 8910   # Default port

var peer

func _ready():
	# Check for command-line arguments
	var args = OS.get_cmdline_args()

	if "--server" in args:
		# Look for the --port argument and get the value after it
		var port_index = args.find("--port")
		if port_index != -1 and port_index + 1 < args.size():
			port = int(args[port_index + 1])  # Get the next argument and use it as the port
			print("Port set to: " + str(port))
		else:
			print("Using default port: " + str(port))

		print("Server Address: " + Address)
		print("Local Addresses: " + str(IP.get_local_addresses()))
		
		hostGame()
#dont need on server side 
func PlayerConnected(id):
	print("Player connected: " + str(id))
#dont need on server side 
func PlayerDisconnected(id):
	print("Player disconnected: " + str(id))

func connected_to_server():
	print("A client connected to the server!")
	print(multiplayer.get_peers())

func connection_failed():
	print("A client failed to connect to the server.")

func hostGame():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)  # 2 clients (excluding the server itself)

	if error != OK:
		print("Cannot host server, error: " + str(error))
		return

	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	
	print("Server started successfully.")

@rpc("any_peer")
func sendPlayerInformation(name, id):
	if!GameManager.Player.has(id):
		GameManager.Player[id] = {
			"name" : name,
			"id" : id,
			"score": 0
			#used to id in game
		}
	if multiplayer.is_server():
		for i in GameManager.Player:
			sendPlayerInformation.rpc(GameManager.Player[i].name,i)




# Server - Function to receive messages from clients
@rpc("any_peer")
func receive_message(message):
	# Get the sender's ID
	var sender_id = get_tree().get_multiplayer().get_remote_sender_id()

	# Print the message with the sender's ID
	print("Server received message from Client " + str(sender_id) + ": ", message)

	# Forward the message to all clients except the sender
	for peer_id in get_tree().get_multiplayer().get_peers():
		if peer_id != sender_id:
			rpc_id(peer_id, "receive_message", "Client " + str(sender_id) + ": " + message)
