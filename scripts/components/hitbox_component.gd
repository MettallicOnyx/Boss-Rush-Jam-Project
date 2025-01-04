extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var hitbox: CollisionShape2D


#This component just passes damage from ATTACK COMPONENT to the HEALTH COMPONENT
func damage(attack):
	if health_component: health_component.damage(attack)
	
func get_class_name():
	return "HitboxComponent"
