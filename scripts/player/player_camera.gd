extends Camera2D

var player: Node2D

@export var shake_strength: float = 20.0
@export var decay_speed: float = 5.0

func _ready() -> void:
	player = get_parent()
	global_position = player.global_position

func _process(delta) -> void:
	global_position.x = player.global_position.x
	global_position.y = clamp(player.global_position.y, player.global_position.y-104, player.global_position.y+5.4)
	offset = lerp(offset, Vector2.ZERO, decay_speed * delta)

func shake(strength: float) -> void:
	offset = Vector2(randf_range(-strength, strength), randf_range(-strength, strength))

func _on_gun_shot_fired() -> void:
	shake(shake_strength)
