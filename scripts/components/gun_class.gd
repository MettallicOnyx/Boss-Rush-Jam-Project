extends Node2D
class_name Gun

const BULLET = preload("res://scenes/weapons/bullet.tscn")

@export var clip_size: int #how many bullets the gun can hold at once
@export var ammo_in_clip: int #ammo currently in the gun
var current_ammo: int #how many ammo the player has in their inventory

@onready var player: CharacterBody2D = $".."

func shoot_bullet(muzzle):
	ammo_in_clip -= 1
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation

func do_recoil(recoil_strength):
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
