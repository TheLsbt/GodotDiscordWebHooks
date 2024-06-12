extends Node

const WEBHOOK_URL: String = ""


func _ready() -> void:
	var webhook := DiscordWebHook.new(WEBHOOK_URL)
	webhook.set_content("Message")

	var response: DiscordWebHook.Response = await webhook.excecute()
	if response.error != null:
		printerr(response.error)
