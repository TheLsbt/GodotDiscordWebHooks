extends Node

const WEBHOOK_URL: String = ""

var webhook: DiscordWebHook = null
var message_id := ""

# The amount of seconds left
var seconds_left := 10.0
# A variable to track the current second
var current_second = 0.0


func _ready() -> void:
	# Create a webhook
	webhook = DiscordWebHook.new(WEBHOOK_URL)

	# Create a embed and set the time and description
	var embed: DiscordWebHook.WebHookEmbed = webhook.add_embed()
	embed.title("Countdown").description("There are")
	# We have to add the string together becuase formating doesnt work? Maybe some bug.
	embed.description("There are " + str(roundi(seconds_left)) + " seconds left.")

	# The example below also works because embeds support Chainableᵗᵐ
	# embed.title("Countdown").description("There are %o seconds left" %roundi(seconds_left))

	# We set initial response becuase we need to reference
	message_id = (await webhook.post()).message_id


func _process(delta: float) -> void:
	if message_id.is_empty():
		return

	current_second = current_second + delta
	if current_second >= 1.0:
		update_message()
		seconds_left = seconds_left - current_second
		current_second = 0

	if seconds_left < 0:
		var previous_embed: DiscordWebHook.WebHookEmbed = webhook.data.get("embeds", [null])[0]
		if previous_embed == null:
			return
		previous_embed.description("🎉 Timer Finished! 🎉")
		webhook.edit(message_id)
		message_id = ""



func update_message() -> void:
	# Currently there is no proper way of getting a embed, but we know we will ever have one we can
	var previous_embed: DiscordWebHook.WebHookEmbed = webhook.data.get("embeds", [null])[0]
	if previous_embed == null:
		return

	# We have to add the string together becuase formating doesnt work? Maybe some bug.
	previous_embed.description("There are " + str(roundi(seconds_left)) + " seconds left.")
	webhook.edit(message_id)


