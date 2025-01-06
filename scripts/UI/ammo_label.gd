extends Label
@export var gun: Gun

func _process(delta: float) -> void:
	text = str(gun.ammo_in_clip) + "/" + str(gun.clip_size) + "\nAmmo left: " + str(gun.current_ammo) 
