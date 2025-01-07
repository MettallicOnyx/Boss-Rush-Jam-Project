extends State

@export var speed: float
var player
var enemy
var follow_point

func onEnter():
	player = %Player
	enemy = get_parent().get_parent()

func onUpdate(delta):
	var direction = (player.global_position - enemy.global_position).normalized()
	enemy.velocity = direction * speed
	enemy.look_at(player.global_position)
	enemy.move_and_slide()
