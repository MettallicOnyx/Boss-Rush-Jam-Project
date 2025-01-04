extends Node2D

var health: int = 100

var damage_immunity = false;

func _on_body_entered(body: Node2D) -> void:
	if (body is Bullet && !damage_immunity):
		hit(body)
		
func hit(body:Node2D) -> void:
	body.queue_free()

	health -= 5
	damage_immunity = true;

	if (health <= 0):
		queue_free()

	$Sprite2D.self_modulate = Color(1,0,0)

	await get_tree().create_timer(0.1).timeout
	$Sprite2D.self_modulate = Color.WHITE
	damage_immunity = false
