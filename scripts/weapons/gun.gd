extends Gun

signal shot_fired

#Clip size var determines how much ammo a gun can hold at once

@onready var gunshot: AudioStreamPlayer2D = $Gunshot
@onready var muzzle: Marker2D = $Marker2D

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
			shoot_bullet(muzzle)
			do_recoil(recoil_strength)
			shot_fired.emit()
			gunshot.play()
	if Input.is_action_just_pressed("reload"):
		reload_gun()

func _on_shot_fired() -> void:
	pass
