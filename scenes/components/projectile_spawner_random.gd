extends ProjectileSpawner

var rng = RandomNumberGenerator.new()

func _create_fire_points() -> void:
	
	for i in range(projectiles_per_shot):
		var spawn_point = Node2D.new()
		var dir = rng.randf_range(0, projectile_spread * PI/180)
		print(dir)
		var pos = Vector2(base_radius, 0).rotated(dir)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		fire_point_parent.add_child(spawn_point)
		
func _fire_projectiles() -> void:
	for fire_point in fire_point_parent.get_children():
		fire_point_parent.remove_child(fire_point)
		fire_point.queue_free()
		
	_create_fire_points()
	
	super()
