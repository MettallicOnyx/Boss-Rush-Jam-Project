extends Node2D

@export var attack_component: AttackComponent 
@export var damage_time: float = 0.3

@export var min_spin_speed: float = 4;
@export var max_spin_speed: float = 12;

@export var charge_spins: int = 10 

var player: Player

var is_spinning : bool = false
var spin_speed: float 
var elapsed: float = 0.0

var player_dir: Vector2
var weapon_rotation: float

var can_hit: bool = false

func _ready() -> void:
	player = get_parent()
	attack_component.process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		player_dir = player.position - player.velocity
		if !can_hit && !is_spinning:
			look_at(player_dir)

	if is_spinning:
		spin_move(delta)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		can_hit = false
		weapon_rotation = rotation
		is_spinning = true;
		spin_speed = min_spin_speed
	elif Input.is_action_just_released("shoot"):
		can_hit = true

func attack(return_point: Vector2) -> void:
	rotation -= PI
	attack_component.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(damage_time).timeout
	attack_component.process_mode = Node.PROCESS_MODE_DISABLED
	look_at(return_point)
	can_hit = false
	
func spin_move(delta: float):
	spin_speed = clamp(spin_speed, min_spin_speed, max_spin_speed)
	rotation = lerp_angle(weapon_rotation,weapon_rotation + 360, elapsed);

	elapsed += delta * spin_speed

	if elapsed >= 3.5:
		elapsed = 0
		spin_speed += (max_spin_speed - min_spin_speed) / charge_spins
		elapsed += delta * spin_speed
		
	if can_hit:
		elapsed = 0
		is_spinning = false
		look_at(player_dir)
		var return_point: Vector2 = player_dir
		attack(return_point)
