extends Node2D

var player: Player
@export var attack_component: AttackComponent 
@export var damage_time: float = 0.3

var is_spinning : bool = false
var spin_speed: float = 4;
var elapsed: float = 0.0

var weapon_rotation: float

var can_hit: bool = false

func _ready() -> void:
	player = get_parent()
	attack_component.process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	if !can_hit && !is_spinning:
		look_at(player.position - player.velocity)

	if is_spinning:
		spin_move(delta)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		weapon_rotation = rotation
		is_spinning = true;
		

func attack() -> void:
	can_hit = true
	rotation -= PI

	attack_component.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(damage_time).timeout
	attack_component.process_mode = Node.PROCESS_MODE_DISABLED
	rotation = weapon_rotation
	can_hit = false

func spin_move(delta: float):
	rotation = lerp_angle(weapon_rotation,weapon_rotation + 360, elapsed);

	elapsed += delta * spin_speed

	if elapsed >= 3.5:
		is_spinning = false
		rotation = weapon_rotation
		elapsed = 0
		attack()
