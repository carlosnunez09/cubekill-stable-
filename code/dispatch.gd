extends Node

@export var http_request: HTTPRequest
var port


func _ready():
	return


func test_dispatch():
	http_request.request_completed.connect(_on_request_completed)
	var url = "http://13.59.141.187:808/api/join"
	var error = http_request.request(url)
	
	if error != OK:
		print("Failed to send request to instance manager.")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var data = JSON.parse_string(body.get_string_from_utf8())
		if data:
			print("Successfully joined lobby:")
			print("Instance Port:", data.get("port", "Unknown"))
			print("Instance ID:", data.get("instance_id", "Unknown"))
			port = data.get("port", "Unknown")
		else:
			print("Failed to parse response.")
	else:
		print("Failed to join instance. Status code:", response_code)
		
