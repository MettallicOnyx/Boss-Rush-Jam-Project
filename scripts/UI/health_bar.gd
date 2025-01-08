extends TextureProgressBar

@onready var player: Player = %Player
var player_health: HealthComponent

func _ready() -> void:
	player_health = player.health_component
	max_value = player_health.health; 

func _process(_delta: float) -> void:
	if player_health != null:
		value = player_health.health
		return
	
	get_tree().quit() # closes game (for now)
