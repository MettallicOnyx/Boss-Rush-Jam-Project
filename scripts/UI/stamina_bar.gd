extends TextureProgressBar

@export var regenerate_time: float = 0.2
@export var regenerate_delay: float = 3.0

@onready var player: Player = %Player
var is_regen: bool = false

func _process(delta: float) -> void:
	value = player.stamina

	if !player.is_dashing && !is_regen:
		await get_tree().create_timer(regenerate_delay).timeout
		is_regen = true
	else:
		is_regen = false
		
	if is_regen:
		regenerate(delta)

func regenerate(delta: float) -> void:
	player.stamina = lerpf(player.stamina, 100.0, delta * regenerate_time)
	
	
