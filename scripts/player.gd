extends CharacterBody2D

@export var speed = 200
@export var accel = 10
@export var animation_player : AnimatedSprite2D
var current_dir = "none"

@onready var gun: Node2D = $Gun

func _physics_process(_delta: float) -> void:
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	var direction = Vector2(direction_x, direction_y)
	
	if Input.is_action_pressed("left") && !direction_y:
		handle_animation("left", true, "side_walk")
	elif Input.is_action_pressed("right") && !direction_y:
		handle_animation("right", false, "side_walk")
	elif Input.is_action_pressed("up"):
		handle_animation("up", true, "back_walk")
	elif Input.is_action_pressed("down"):
		handle_animation("down", true, "walk")
	
	if Input.is_action_just_released("left"):
		animation_player.play("side_idle")
	if Input.is_action_just_released("right"):
		animation_player.play("side_idle")
	if Input.is_action_just_released("up"):
		animation_player.play("back_idle")
	if Input.is_action_just_released("down"):
		animation_player.play("idle")
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	

func handle_animation(direction, is_flipped, animation_name):
		current_dir = direction
		animation_player.flip_h = is_flipped
		animation_player.play(animation_name)
