extends Node

const WEBHOOK_URL: String = ""

var webhook: DiscordWebHook = null


func _ready() -> void:
	webhook = DiscordWebHook.new(WEBHOOK_URL)
	webhook.message("Hello from godot!")
	webhook.post()


