extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
# Function that gets called when the button is pressed.
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	print("#########
		   ######### 0.018")
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
		
		var customIP_index = args.find("--ip")
		if customIP_index != -1 and customIP_index + 1 < args.size():
			Address = args[customIP_index + 1]
			print("Custom IP set to: " + Address)
		else:
			print("using default IP Address: " + Address)
			
	print("Server Address: " + Address)
	print("Local Addresses: " + str(IP.get_local_addresses()))


#peer connected
func PlayerConnected(id):
	print("player connected" + str(id))
	
	
	
#peer connected
func PlayerDisconnected(id):
	print("player disconnected" + str(id))
	
#called only from clients
func connected_to_server(id):
	print("player connected to server!" + str(id))
	sendPlayerInformation.rpc_id(1,$name.text, multiplayer.get_unique_id())
	
	
	
	
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
	#sendPlayerInformation($name.text,multiplayer.get_unique_id())
	pass # Replace with function body.




func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,port)
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.
