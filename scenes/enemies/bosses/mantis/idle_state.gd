extends State

@export var idle_timer: Timer

func onEnter():
	idle_timer.start()
	animationPlayer.play("idle")

func _on_idle_time_timeout() -> void:
	transitioned.emit(next_state[0].name)

func onExit():
	idle_timer.stop()
