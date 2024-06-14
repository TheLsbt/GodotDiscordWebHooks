# Welcome to GodotDiscordWebHooks

> [!WARNING]
> Be sure to check the [unsupported features](https://github.com/TheLsbt/GodotDiscordWebHooks/wiki/Features#unsupported-features) to ensure that you can use this plugin efficiently.

Checkout the [api in action](https://github.com/TheLsbt/GodotDiscordWebHooks#api-in-action)

## Getting started
1. To get started with GodotDiscordWebHooks install this plugin either from downloading / cloning the GitHub repository.
3. Get a [webhook url](https://github.com/TheLsbt/GodotDiscordWebHooks#get-a-webhook-url) if you haven't already.
4. Next you can [create your first message](https://github.com/TheLsbt/GodotDiscordWebHooks#my-first-message)


## My first message
1. After installing the files for GodotDiscordWebHooks, create a scene and attach a node to the root.
2. Open the script and create a _ready() function.
```gdscript
# In res://Node.gd
func  _ready() -> void:
   pass
```
3. Create a webhook object to send content and change the webhooks username. Remember to replace `WEBHOOK_URL` with your webhook's url. Get a [webhook url](https://github.com/TheLsbt/GodotDiscordWebHooks/wiki/Home/_edit#get-a-webhook-url) if you haven't already.
```gdscript
# In res://Node.gd
func _read() -> void:
    var webhook := DiscordWebHook.new(WEBHOOK_URL)
    webhook.message("Hello from godot!")
    webhook.username("A robot")
    # DiscordWebHook allows chaining so the above code can also be written as:
    # webhook.message("Hello from godot!").username("A robot")

```
4. Finally, we post the message, for this introduction we won't be doing anything with the response so we won't cast it
```gdscript
# In res://Node.gd
func _read() -> void:
    var webhook := DiscordWebHook.new(WEBHOOK_URL)
    webhook.message("Hello from godot!")
    webhook.username("A robot")

    # Post the message
    await webhook.post()
```

## Get a webhook url
 1. ![Screenshot 2024-06-12 153035](https://github.com/TheLsbt/DiscordWebHooks/assets/141819348/51360b09-7a1a-4745-8328-98f40c494246)
 2. ![CreateWebhook](https://github.com/TheLsbt/DiscordWebHooks/assets/141819348/59954545-994d-4019-a78a-e9d7caad3f85)
 3. ![GettingWebhookUrl](https://github.com/TheLsbt/DiscordWebHooks/assets/141819348/b05af915-c95d-438f-92ec-6390dfbe442b)


## Api in action
![Screenshot 2024-06-14 040147](https://github.com/TheLsbt/GodotDiscordWebHooks/assets/141819348/1b2b3ba5-b314-4385-b37c-ba0babcb2f3e)
![Screenshot 2024-06-14 040403](https://github.com/TheLsbt/GodotDiscordWebHooks/assets/141819348/a737e4ce-572e-4474-b3c5-cd6447bba77b)
