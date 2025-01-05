extends CharacterBody2D

class_name Bullet

const SPEED: int = 1000

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func destroySelf():
	self.queue_free()
