extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : int
var health: int
var parent: Node2D

func _enter_tree() -> void:
	parent = get_parent()
	if MAX_HEALTH && MAX_HEALTH > 0:
		health = MAX_HEALTH

func damage(attack):
	health -= attack
	parent.animate_hit()
	if health <= 0: get_parent().queue_free()
