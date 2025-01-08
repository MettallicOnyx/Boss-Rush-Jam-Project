extends Node2D
class_name ProjectileSpawner

@export var projectile_prefab: PackedScene
@export var initial_base_rotation: float = 0
@export var base_rotation_step: float  = 30
@export var base_radius: int = 100
@export var projectile_spread: float = 360
@export var projectiles_per_shot: int = 4
@export var shot_count: int = -1
@export var sequence_count: int = 1
@export var _on_complete_sequence: Callable = Callable(self, "_placeholder_callable")
@export var _on_complete_all_sequences: Callable = Callable(self, "_placeholder_callable_all")

var _shots_fired: int = 0
var _sequences_completed: int = 0
var _initial_calculated_base_rotation: float

@onready var fire_point_parent = $FirePointParent
@onready var shoot_timer = $ShootTimer
@onready var sequence_timer = $SequenceTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_fire_points()
	_rotate_fire_point_parent(initial_base_rotation)
	_initial_calculated_base_rotation = fire_point_parent.rotation_degrees
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#_rotate_fire_point_parent(delta)
	
func activate_spawner():
	_sequences_completed = 0
	_reset_sequence()
	
func _create_fire_points() -> void:
	var step = projectile_spread * PI/180 / projectiles_per_shot
	
	for i in range(projectiles_per_shot):
		var spawn_point = Node2D.new()
		var pos = Vector2(base_radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		fire_point_parent.add_child(spawn_point)
		
func _fire_projectiles() -> void:
	for fire_point in fire_point_parent.get_children():
		var bullet = projectile_prefab.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = fire_point.global_position
		bullet.rotation = fire_point.global_rotation	

	
func _rotate_fire_point_parent(step: float) -> void: 
	var new_rotation = fire_point_parent.rotation_degrees + step
	fire_point_parent.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout() -> void:
	_fire_projectiles()
	_rotate_fire_point_parent(base_rotation_step)
	_shots_fired += 1;
	
	if (shot_count != -1 && _shots_fired >= shot_count):
		_end_sequence()
		
func _on_sequence_timer_timeout() -> void:
	_reset_sequence()

func _placeholder_callable():
	pass
	
func _placeholder_callable_all():
	pass
	
func _end_sequence() -> void:
	_on_complete_sequence.call()
	shoot_timer.stop()
	_sequences_completed += 1
	if (sequence_count == -1 || _sequences_completed < sequence_count):
		sequence_timer.start()
	else:
		_on_complete_all_sequences.call()
	
func _reset_sequence() -> void:
	_shots_fired = 0;
	fire_point_parent.rotation_degrees = _initial_calculated_base_rotation
	shoot_timer.start()
	
