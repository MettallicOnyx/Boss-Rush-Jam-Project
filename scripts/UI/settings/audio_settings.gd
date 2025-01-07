extends Control

@export var music_slider: Slider
@export var sfx_slider: Slider

func _process(_delta: float) -> void:
	update_music_volume()
	update_sfx_volume()

func update_music_volume():
	var volume: float = music_slider.value
	music_slider.get_child(0).text = "Music: " + str(volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume - 80)

func update_sfx_volume():
	var volume: float = sfx_slider.value
	sfx_slider.get_child(0).text = "Sound Effects: " + str(volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume - 80)

func _on_return_pressed() -> void:
	get_parent().show_audio_settings(false)
