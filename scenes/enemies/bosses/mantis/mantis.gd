extends CharacterBody2D

@onready var fms: FMS = $FMS
@onready var attack_state: Node = $FMS/attack_state


func _physics_process(delta: float) -> void:
	print(velocity)


func _on_detection_area_body_entered(body: Node2D) -> void:
	fms.on_state_transition(attack_state.name)
