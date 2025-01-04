extends Node2D

#func _on_body_entered(body: Node2D) -> void:
	#if (body is Bullet && !damage_immunity):
		#hit(body)
		#
#func hit(body:Node2D) -> void:
	#body.queue_free()
#
	#health -= 5
	#damage_immunity = true;
#
	#if (health <= 0):
		#queue_free()
		
#		example function for animating hit
#we should find a good shader animation and/or play the sprites hit animation instead
func animateHit():
	$Sprite2D.self_modulate = Color(1,0,0)
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.self_modulate = Color.WHITE
