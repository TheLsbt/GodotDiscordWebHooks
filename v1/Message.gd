extends RefCounted
class_name DiscordMessage


var content: String = ""
var username: String = ""
## Any valid url
var profile_picture: String = ""
var tts := false
## This gets converted to data["flags"] before it is sent
var supress_embeds := false
var supress_notifications := false
## This can not be set manually please use [method add_attachment]
var attachments := []




func get_payload() -> Dictionary:
	return {}


## Chain-able
func set_param(param: String, value: Variant) -> DiscordMessage:
	set(param, value)
	return self


# Chain-able
func add_attachment(path: String, description: String, filename_overrride: String = "") -> DiscordMessage:
	return self
