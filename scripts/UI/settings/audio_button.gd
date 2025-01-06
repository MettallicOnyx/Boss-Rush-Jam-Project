extends Button

@export var audio_settings: Control

func _ready() -> void:
	show_audio_settings(false)

func _on_pressed() -> void:
	show_audio_settings(true)

func show_audio_settings(state: bool):
	for child in get_parent().get_children():
		child.visible = !state
		audio_settings.visible = state
