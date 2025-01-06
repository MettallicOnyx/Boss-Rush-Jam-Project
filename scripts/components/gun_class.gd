extends Node2D
class_name Gun

@export var clip_size: int #how many bullets the gun can hold at once
@export var ammo_in_clip: int #ammo currently in the gun
var current_ammo: int #how many ammo the player has in their inventory
