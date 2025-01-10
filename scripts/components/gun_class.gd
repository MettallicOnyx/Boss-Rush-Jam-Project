extends Node2D
class_name Gun

const BULLET = preload("res://scenes/weapons/bullet.tscn")

@export var clip_size: int #how many bullets the gun can hold at once
@export var ammo_in_clip: int #ammo currently in the gun
@export var extra_damage: int #extra damage to add per charge gained by spinning
var current_ammo: int #how many ammo the player has in their inventory

@onready var player: CharacterBody2D = $".."

func shoot_bullet(muzzle, mod = 0):
	ammo_in_clip -= 1
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	bullet_instance.get_node("attack_component").add_damage(mod * extra_damage)

func do_recoil(recoil_strength, mod = 0):
	var recoil_angle := player.position.angle_to_point(get_global_mouse_position())
	var recoil_dir := -Vector2.RIGHT.rotated(recoil_angle);
	
	player.velocity = recoil_dir * recoil_strength * mod;

func reload_gun():
	if ammo_in_clip < clip_size:
		var ammo_needed = clip_size - ammo_in_clip 
		var ammo_to_reload = min(ammo_needed, current_ammo)

		ammo_in_clip += ammo_to_reload
		current_ammo -= ammo_to_reload
