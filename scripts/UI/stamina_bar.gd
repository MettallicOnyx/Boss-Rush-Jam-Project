extends TextureProgressBar

@onready var player: Player = %Player

func _process(_delta: float) -> void:
	value = player.stamina
