extends Node

const INSTANCE_MANAGER_URL = "http://localhost:808/api/join"
var http_request : HTTPRequest

func _ready():
	request_instance()

func request_instance():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	
	var error = http_request.request(INSTANCE_MANAGER_URL)
	if error != OK:
		print("Failed to create HTTP request")
		http_request.queue_free()

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	if response_code == 200:
		var json = JSON.new()
		var parse_error = json.parse(body.get_string_from_utf8())
		
		if parse_error == OK:
			var response_data = json.get_data()
			var lobby_id = generate_uuid()
			
			print("Successfully joined lobby:")
			print("Lobby ID: ", lobby_id)
			print("Instance Port: ", response_data.get("port", "N/A"))
			print("Instance ID: ", response_data.get("instance_id", "N/A"))
		else:
			print("Failed to parse JSON response")
	else:
		print("Failed to join instance. Status code: ", response_code)
	
	if http_request != null:
		http_request.queue_free()

func generate_uuid() -> String:
	var uuid := ""
	var hex_chars := "0123456789abcdef"
	
	for i in 36:
		match i:
			8, 13, 18, 23:
				uuid += "-"
			14:
				uuid += "4"
			19:
				uuid += hex_chars[(randi() % 4) + 8]
			_:
				uuid += hex_chars[randi() % 16]
	
	return uuid
