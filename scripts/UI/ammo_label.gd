extends Label

@onready var player: Player = %Player
var gun: Gun

func _ready() -> void:
	gun = player.weapon_list[0]

func _process(_delta: float) -> void:
	text = str(gun.ammo_in_clip) + "/" + str(gun.clip_size) + "\nAmmo left: " + str(gun.current_ammo) 
