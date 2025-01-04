extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D
@onready var player: CharacterBody2D = $".."

var recoil_strength: float = 300.0

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		player.velocity = Vector2.ZERO
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation

		
		var recoil_angle := player.position.angle_to_point(get_global_mouse_position())
		var recoil_dir := -Vector2.RIGHT.rotated(recoil_angle);
		
		if player.velocity.x > 0 || player.velocity.y > 0: 
			player.velocity = -recoil_dir * recoil_strength;
		else:
			player.velocity = recoil_dir * recoil_strength;
		
		
