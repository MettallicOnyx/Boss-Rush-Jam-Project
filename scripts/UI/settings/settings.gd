extends Panel

@export var audio_settings: Control

func _ready() -> void:
	get_tree().paused = true
	toggle_active()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("settings"):
		toggle_active()

func toggle_active() -> void:
	visible = !visible
	get_tree().paused = !get_tree().paused

	
func show_audio_settings(state: bool):
	for child in get_children():
		child.visible = !state
	audio_settings.visible = state
