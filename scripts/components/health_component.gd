extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : int
var health
var parent

func  _ready() -> void:
	parent = get_parent()
	if MAX_HEALTH && MAX_HEALTH > 0:
		health = MAX_HEALTH

func damage(attack):
	health -= attack
	parent.animateHit()
	if health <= 0: get_parent().queue_free()
