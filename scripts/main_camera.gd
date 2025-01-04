extends Camera2D

@export var shake_strength: float = 500.0
@export var decay_speed: float = 50.0

func _process(delta: float) -> void:
	offset = lerp(offset, Vector2.ZERO, decay_speed * delta)

func shake(strength: float) -> void:
	offset = Vector2(randf_range(-strength, strength), randf_range(-strength, strength))

func _on_gun_shot_fired() -> void:
	shake(shake_strength)
