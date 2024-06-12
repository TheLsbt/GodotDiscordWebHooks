extends RefCounted

var embed: Dictionary = {}

# NOTE:
# For the webhook embed objects, you can set every field except type
# (it will be rich regardless of if you try to set it), provider, video, and any height, width,
# or proxy_url values for images.


func to_json() -> Dictionary:
	return embed


func set_title(title: String) -> DiscordWebHook.WebHookEmbed:
	embed["title"] = title
	return self


func set_color(color: Color) -> DiscordWebHook.WebHookEmbed:
	embed["color"] = DiscordWebHook.rgb_to_hex(color)
	return self


func set_description(description: String) -> DiscordWebHook.WebHookEmbed:
	embed["description"] = description
	return self


func set_url(url: String) -> DiscordWebHook.WebHookEmbed:
	embed["url"] = url
	return self


## [param timestamp] Must be a valid ISO8601 timestamp
func set_timestamp(timestamp: String) -> DiscordWebHook.WebHookEmbed:
	embed["timestamp"] = timestamp
	return self


func set_footer(text: String, icon_url := "", icon_proxy_url := "") -> DiscordWebHook.WebHookEmbed:
	embed["footer"] = {
		"text": text, "icon_url": icon_url, "icon_proxy_url": icon_proxy_url
	}
	return self


func set_image(url: String) -> DiscordWebHook.WebHookEmbed:
	# NOTE: That image objects
	embed["image"] = {
		"url": url,
	}
	return self


func set_thumbnail(url: String, proxy_url := "", size := Vector2i()) -> DiscordWebHook.WebHookEmbed:
	embed["thumbnail"] = {
		"url": url,
		"proxy_url": proxy_url,
		"width": size.x,
		"height": size.y
	}
	return self


func set_author(name: String, url := "", icon_url := "", proxy_icon_url := "") -> DiscordWebHook.WebHookEmbed:
	embed["author"] = {
		"name": name,
		"url": url,
		"icon_url": icon_url,
		"proxy_icon_url": proxy_icon_url,
	}
	return self


func add_field(name: String, value: String, inline := false) -> DiscordWebHook.WebHookEmbed:
	if not embed.has("fields"):
		embed["fields"] = []

	embed["fields"].append({
		"name": name,
		"value": value,
		"inline": inline
	})

	return self
