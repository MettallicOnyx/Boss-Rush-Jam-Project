extends State

@export var hurtbox: CollisionShape2D

func onEnter():
	animationPlayer.play("attack1")


func _on_animated_sprite_2d_frame_changed() -> void:
	if animationPlayer.frame == 4:
		hurtbox.disabled = false
	elif animationPlayer.frame == 9:
		hurtbox.disabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	transitioned.emit(next_state[0].name)
