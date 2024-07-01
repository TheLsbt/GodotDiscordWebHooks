extends RefCounted

# The headers for our request
var _headers = []


func send(message) -> void:
	pass


func edit() -> void:
	pass


func delete() -> void:
	pass


func _send_request() -> void:
	var client = HTTPClient.new()


func _send_raw_request() -> void:
	pass
