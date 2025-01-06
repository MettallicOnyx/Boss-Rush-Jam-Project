extends Control

@export var master_volume_slider: Slider

func _ready() -> void:
	master_volume_slider.value = 100

func _process(_delta: float) -> void:
	update_volume()

func update_volume() -> void:
	master_volume_slider.get_child(0).text = "Master Volume: " + str(master_volume_slider.value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_volume_slider.value - 80)
