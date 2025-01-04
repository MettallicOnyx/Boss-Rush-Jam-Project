extends TextureProgressBar

@export var player: Player
var playerHealth: HealthComponent

func _ready() -> void:
	playerHealth = player.health_component
	max_value = playerHealth.health; 

func _process(_delta: float) -> void:
	if playerHealth != null:
		value = playerHealth.health
		return
	
	get_tree().quit() # closes game (for now)
