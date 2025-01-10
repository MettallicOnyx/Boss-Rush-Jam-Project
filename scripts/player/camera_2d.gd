extends Camera2D

@export var player: Node2D  # Drag the player node here

func _process(delta):
	global_position.x = 0
	global_position.y = clamp(player.global_position.y, -104, 5.4)
