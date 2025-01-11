extends TextureProgressBar

@export var regenerate_time: float = 0.2

@onready var player: Player = %Player
@onready var regen_timer: Timer = $"Recharge Timer"
var is_regen: bool = false

func _process(delta: float) -> void:

	if is_regen && !player.is_dashing:
		regenerate(delta)
		
	if player.is_dashing:
		is_regen = false
		
	value = player.stamina

func regenerate(delta: float) -> void:
	player.stamina = lerpf(player.stamina, 100.0, delta * regenerate_time)
	

func _on_player_dashed() -> void:
	regen_timer.start()
	await regen_timer.timeout
	is_regen = true 
