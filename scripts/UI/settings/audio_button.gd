extends Button

var settings: Panel

func _ready() -> void:
	settings = get_parent()
	settings.show_audio_settings(false)

func _on_pressed() -> void:
	settings.show_audio_settings(true)
