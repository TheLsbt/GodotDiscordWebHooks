extends RefCounted

##[color=#f6df61]NOTE: For the webhook embed objects, you can set every field except type
##(it will be rich regardless of if you try to set it), provider, video, and any height, width,
##or proxy_url values for images.[/color]
##[br][br]Methods are self explanitory and almost all are Chainableᵗᵐ

## This is the data that gets stored and sent to discord
var embed: Dictionary = {}


## This method returns [member embed]. Currently it returns the raw variable but in the future it
## might modifiy the data in variable
func to_json() -> Dictionary:
	return embed


## Chainableᵗᵐ
func title(title: String) -> DiscordWebHook.WebHookEmbed:
	embed["title"] = title
	return self


## Chainableᵗᵐ
func color(color: Color) -> DiscordWebHook.WebHookEmbed:
	embed["color"] = DiscordWebHook.rgb_to_hex(color)
	return self


## Chainableᵗᵐ
func description(description: String) -> DiscordWebHook.WebHookEmbed:
	embed["description"] = description
	return self


## Chainableᵗᵐ, highlights [param title] with the link color and makes the title clickable
func url(url: String) -> DiscordWebHook.WebHookEmbed:
	embed["url"] = url
	return self


## Chainableᵗᵐ, [param timestamp] Must be a valid ISO8601 timestamp
func timestamp(timestamp: String) -> DiscordWebHook.WebHookEmbed:
	embed["timestamp"] = timestamp
	return self


## Chainableᵗᵐ
func footer(text: String, icon_url := "") -> DiscordWebHook.WebHookEmbed:
	embed["footer"] = {
		"text": text, "icon_url": icon_url
	}
	return self


## Chainableᵗᵐ
func image(url: String) -> DiscordWebHook.WebHookEmbed:
	# NOTE: That image objects
	embed["image"] = {
		"url": url,
	}
	return self


## Chainableᵗᵐ
func thumbnail(url: String) -> DiscordWebHook.WebHookEmbed:
	embed["thumbnail"] = {
		"url": url,
	}
	return self


## Chainableᵗᵐ
func author(name: String, url := "", icon_url := "") -> DiscordWebHook.WebHookEmbed:
	embed["author"] = {
		"name": name,
		"url": url,
		"icon_url": icon_url,
	}
	return self


## Chainableᵗᵐ, [param value] can accept markdown links
func add_field(name: String, value: String, inline := false) -> DiscordWebHook.WebHookEmbed:
	if not embed.has("fields"):
		embed["fields"] = []

	embed["fields"].append({
		"name": name,
		"value": value,
		"inline": inline
	})

	return self
