extends Node2D

@export var attack_component: AttackComponent 
@export var damage_time: float = 0.3

@export var spin_speed = 4 

var player: Player

var is_spinning : bool = false

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

func attack(return_point: Vector2) -> void:
	rotation -= PI
	attack_component.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(damage_time).timeout
	attack_component.process_mode = Node.PROCESS_MODE_DISABLED
	look_at(return_point)
	can_hit = false
	
func spin_move(delta: float) -> void:
	rotation = lerp_angle(weapon_rotation,weapon_rotation + 360, elapsed);

	elapsed += delta * spin_speed

	if elapsed >= 3.6:
		elapsed = 0
		can_hit = true

		elapsed = 0
		is_spinning = false
		look_at(player_dir)
		var return_point: Vector2 = player_dir
		attack(return_point)
