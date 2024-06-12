extends Node
class_name DiscordWebHook

const ALLOWED_MENTION_TYPES := {
	 "RoleMentions": "roles", "UserMentions": "users", "EveryoneMentions": "everyone"
	}

var HEADERS: PackedStringArray = ["Accept: application/json", "Content-Type: application/json"]
const PORT := 443
const API_HOST := "https://discord.com"


const WebHookEmbed = preload("./DiscordWebHookEmbed.gd")

var client: HTTPClient
var webhook_url: String = ""
var data: Dictionary = {}

class Response:
	var code: int = -1
	var headers: Dictionary = {}
	var body: PackedByteArray = []
	var error = null

	# Determine if this response was chunked
	var chunked := false

	func text() -> String:
		return body.get_string_from_utf8()


func _init(url: String) -> void:
	client = HTTPClient.new()
	webhook_url = "/" + url.lstrip(API_HOST)

	# This node adds itself to the scene tree
	Engine.get_main_loop().root.add_child.call_deferred(self)
	_connect_to_discord()


func _connect_to_discord() -> void:
	 # Connect to host/port.
	if client.connect_to_host(API_HOST, PORT) != OK:
		printerr("Failed to connect to %s, try again using [connect_to_discord]" %API_HOST)
		return

	# Wait until resolved and connected.
	while client.get_status() == HTTPClient.STATUS_CONNECTING or client.get_status() == HTTPClient.STATUS_RESOLVING:
		client.poll()

	if client.get_status() == HTTPClient.STATUS_CONNECTED:
		print("Connected to 'https://discord.com'")
	else:
		printerr("Could not connect to 'https://discord.com'")


# Helper function
func len_limit_string(string: String, length: int) -> String:
	return string.left(length)


func excecute() -> Response:
	var parsed: Dictionary = data.duplicate()
	if parsed.has("embeds"):
		parsed["embeds"] = []
		for embed: WebHookEmbed in data.get("embeds", []):
			parsed["embeds"].append(embed.to_json())
	return await post(JSON.stringify(parsed))


#region Message

func set_content(content: String) -> void:
	data["content"] = content


func set_username(username: String) -> void:
	data["username"] = username


func set_profile_picture(url: String) -> void:
	data["avatar_url"] = url


func send_as_tts(tts: bool) -> void:
	data["tts"] = tts


## Creates an embed and returns it
func add_embed() -> WebHookEmbed:
	if not data.has("embeds"):
		data["embeds"] = []

	var embed := WebHookEmbed.new()

	if data["embeds"].size() >= 10:
		printerr("There are currently 10 embeds which are the maximum amount for a message")
		return embed

	data["embeds"].append(embed)

	return embed


## Creates a poll using [param question] (300 character limit) and a list of [param awnsers]
## (Each awnser has a character limit of 55). The poll lasts for [param duration] hours. [br]
## To add emojis to questions make sure that the corosponding [param emojis] index has the right
## 'id' to [param awnsers] index. A message can only ever have one poll so when this method is
## called again it overrides the previous one
func add_poll(question: String, awnsers: PackedStringArray, duration: int, multiselect: bool = false, emojis: PackedStringArray = []) -> DiscordWebHook:
	var awnsers_array: Array = []
	for idx: int in awnsers.size():
		var awnser_text: String = awnsers[idx]
		var awnser: Dictionary = {
			"awnser_id": idx + 1,
			"poll_media": {
				"text": len_limit_string(awnser_text, 55),
			},
		}
		if emojis.size() >= (idx + 1):
			var emoji: String = emojis[idx]
			# If the emoji begins with : and ends with :
			if emoji.begins_with(":") and emoji.ends_with(":"):
				awnser["poll_media"]["emoji"]["name"] = emoji.lstrip(":").rstrip(":")
			# If an emoji is an int then the user wants to add a custom emoji
			elif emoji.is_valid_int():
				awnser["poll_media"]["emoji"]["id"] = emoji

		awnsers_array.append(awnser)

	data["poll"] = {
		"answers": awnsers_array,
		"question": {"text": len_limit_string(question, 300)},
		"duration": duration,
		"allow_multiselect": multiselect
	}
	return self


#endregion



func post(query: String) -> Response:
	var response := Response.new()
	# Request a page from the site
	print("Requesting from ", API_HOST + webhook_url)
	var request_headers = HEADERS
	var err = client.request(HTTPClient.METHOD_POST, API_HOST + webhook_url, request_headers, query)

	if err != OK:
		response.error = "There was an error trying to send your request >> %s" %error_string(err)
		return response

	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling for as long as the request is being processed.
		client.poll()

	if not client.get_status() in [HTTPClient.STATUS_BODY, HTTPClient.STATUS_CONNECTED]:
		printerr("Failed to post a message to discord")

	if client.has_response():
		response.headers = client.get_response_headers_as_dictionary()
		response.code = client.get_response_code()
		response.chunked = client.is_response_chunked()

		# Get the response body
		# Array that will hold the data.
		var chunks = PackedByteArray()
		while client.get_status() == HTTPClient.STATUS_BODY:
			# While there is body left to be read
			client.poll()
			# Get a chunk.
			var chunk = client.read_response_body_chunk()
			if chunk.size() == 0:
				if not OS.has_feature("web"):
					# Got nothing, wait for buffers to fill a bit.
					OS.delay_usec(1000)
				else:
					await Engine.get_main_loop().process_frame
			else:
				# Append to read buffer.
				chunks.append_array(chunk)

		response.body = chunks

	return response


## A helper function, used to color embed objects
static func rgb_to_hex(color: Color) -> int:
	return ("0x"\
	+ _rgb_component_to_hex(roundi(color.r * 255))\
	+ _rgb_component_to_hex(roundi(color.g * 255))\
	+ _rgb_component_to_hex(roundi(color.b * 255))\
	).hex_to_int()


static func _rgb_component_to_hex(number: int) -> String:
	if number == 0:
		return "00"

	var hex_code: String = ""
	while(number != 0):
		var temp_number: int = number % 16
		if(temp_number < 10):
			hex_code += char(temp_number + 48)
		else:
			hex_code += char(temp_number + 55)
		@warning_ignore("integer_division")
		number = int(number / 16)

	return hex_code.reverse()
