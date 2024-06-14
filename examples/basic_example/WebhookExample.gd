extends Node

const WEBHOOK_URL: String = "https://discord.com/api/webhooks/1250442585722589195/iETRcOV7GCWwV1wVYTPs0ZgtelG6DJB6_uF0foQH0UEGUJB9FQOCnZPz9e_nPjbdpfr3"

var webhook: DiscordWebHook = null


func _ready() -> void:
	webhook = DiscordWebHook.new(WEBHOOK_URL)
	webhook.add_poll(
		"Question", ["Awnser 1", "Awnser 2", "Awnser 3"], 1, true
	)
	var response = await webhook.post()
	print(response.text())
