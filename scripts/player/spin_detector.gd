extends Node2D

var power_up_in_progress = false
var total_rotation: float = 0 
var current_spins_completed: int = 0
var last_frame_rotation: float = 0

@onready var gun = get_node("../Gun")
@onready var anim = $AnimatedSprite2D

signal power_up_weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if power_up_in_progress:
		#print(gun.rotation_degrees)
		#print(last_frame_rotation)
		#print(calculate_difference(gun.rotation_degrees, last_frame_rotation))
		total_rotation += calculate_difference(gun.rotation_degrees, last_frame_rotation)
		
		if (abs(total_rotation) > 360):
			current_spins_completed += 1
			current_spins_completed = clamp(current_spins_completed, 0, 2)
			power_up_weapon.emit()
			_on_spin_complete()
			total_rotation = 0
	
	
	last_frame_rotation = gun.rotation_degrees
	
func _on_spin_complete() -> void:
	match current_spins_completed:
		1:
			anim.play("power_up_1")
		2:
			anim.play("power_up_2")
			
func remove_charge() -> void:
	match current_spins_completed:
		1:
			anim.play("power_down_1")
		2:
			anim.play("power_down_2")
			
	current_spins_completed = 0
	
	
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ability"):
		total_rotation = 0
		power_up_in_progress = true
	if (Input.is_action_just_released("ability")):
		power_up_in_progress = false
		
func calculate_difference(no_1, no_2):
	var angle = abs(no_1 - no_2)
	if angle > 180.0:
		return 360.0 - angle
	if (no_1 < no_2):
		angle = -angle
	return angle
	
	
