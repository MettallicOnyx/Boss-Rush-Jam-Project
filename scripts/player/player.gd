extends CharacterBody2D

class_name Player

@export var speed = 200
@export var accel = 10
@export var animation_player : AnimatedSprite2D
@export var health_component: HealthComponent
@export var weapon_list : Array[Node2D]
@export var dash_distance: float = 200.0  # Maximum distance for the dash
@export var dash_speed: float = 500.0  # Speed of the dash

var is_dashing: bool = false
var dash_target: Vector2
var dash_start_position: Vector2


var current_dir = "none"
var weapon_index: int = 0
var ammo_in_inventory = 50

@onready var gun: Node2D = $Gun

func _ready() -> void:
	set_weapon()

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	var direction = Vector2(direction_x, direction_y).normalized()
	
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
	
	#velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	#velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	if is_dashing:
		global_position = global_position.move_toward(dash_target, dash_speed * delta)

		# Check if dash is complete
	if global_position.distance_to(dash_target) < 1.0 or global_position.distance_to(dash_start_position) >= dash_distance:
		is_dashing = false
	
	velocity = velocity.move_toward(direction * speed, accel)
	
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ability"): # for testing purposes (press E)
		health_component.damage(5)

	if Input.is_action_just_pressed("swap_weapon"): # press F
		weapon_index += 1
		set_weapon()
	
	if Input.is_action_just_pressed("dash"):
		dash_start_position = global_position
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		dash_target = global_position + direction * dash_distance
		is_dashing = true

func handle_animation(direction, is_flipped, animation_name):
		current_dir = direction
		animation_player.flip_h = is_flipped
		animation_player.play(animation_name)

func animate_hit() -> void:
	pass

func set_weapon():

	if weapon_index > len(weapon_list) - 1:
		weapon_index = 0

	for weapon in weapon_list:
		weapon.process_mode = Node.PROCESS_MODE_DISABLED
		weapon.visible = false

	weapon_list[weapon_index].process_mode = Node.PROCESS_MODE_INHERIT
	weapon_list[weapon_index].visible = true;
