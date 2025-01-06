extends Area2D
class_name ItemComponent

var parent: Node2D

func _enter_tree() -> void:
	parent = get_parent()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		parent.item_ability(body)
		parent.queue_free()
