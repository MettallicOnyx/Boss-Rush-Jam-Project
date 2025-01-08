extends State

@export var speed: float
@export var chase_timer: Timer
var player
var enemy
var follow_point

func onEnter():
	enemy = get_parent().get_parent()
	player = enemy.get_parent().get_node("Player")
	if animationPlayer: animationPlayer.play("walk")
	chase_timer.start()

func onUpdate(delta):
	var direction = (player.global_position - enemy.global_position).normalized()
	if direction.x < 0:
		animationPlayer.flip_h = false
	else:
		animationPlayer.flip_h = true
	enemy.velocity = direction * speed
	enemy.move_and_slide()

func onExit():
	chase_timer.stop()

func _on_chase_time_timeout() -> void:
	transitioned.emit(next_state[0].name)
