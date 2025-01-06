extends Gun

signal shot_fired

const BULLET = preload("res://scenes/weapons/bullet.tscn")

#Clip size var determines how much ammo a gun can hold at once

@onready var muzzle: Marker2D = $Marker2D
@onready var player: CharacterBody2D = $".."
@onready var gunshot: AudioStreamPlayer2D = $Gunshot

var recoil_strength: float = 300.0

func _ready() -> void:
	shot_fired.connect(_on_shot_fired)
	ammo_in_clip = clip_size
	current_ammo = get_parent().ammo_in_inventory

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		if ammo_in_clip > 0:
			shoot_bullet()
			do_recoil()
			shot_fired.emit()
	if Input.is_action_just_pressed("reload"):
		reload_gun()

func shoot_bullet():
	ammo_in_clip -= 1
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	gunshot.play()

func do_recoil():
	var recoil_angle := player.position.angle_to_point(get_global_mouse_position())
	var recoil_dir := -Vector2.RIGHT.rotated(recoil_angle);
	
	if player.velocity.x > 0 || player.velocity.y > 0: 
		player.velocity = -recoil_dir * recoil_strength;
	else:
		player.velocity = recoil_dir * recoil_strength;

func reload_gun():
	if ammo_in_clip < clip_size:
		var ammo_needed = clip_size - ammo_in_clip 
		var ammo_to_reload = min(ammo_needed, current_ammo)

		ammo_in_clip += ammo_to_reload
		current_ammo -= ammo_to_reload

func _on_shot_fired() -> void:
	pass
