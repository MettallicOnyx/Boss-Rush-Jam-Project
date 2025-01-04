extends CharacterBody2D

@export var speed = 300
@export var accel = 10
var current_dir = "none"

@onready var gun: Node2D = $Gun

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	
	if Input.is_action_pressed("left"):
		current_dir = "left"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("right"):
		current_dir = "right"
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("side_walk")
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("back_walk")
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		current_dir = "down"
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	
	if Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("side_idle")
	if Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("side_idle")
	if Input.is_action_just_released("up"):
		$AnimatedSprite2D.play("back_idle")
	if Input.is_action_just_released("down"):
		$AnimatedSprite2D.play("idle")
	
	
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	
