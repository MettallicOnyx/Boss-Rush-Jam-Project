extends Node
class_name FMS

#The start state
@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	current_state = initial_state
#	we connect the transition signal
	for child in get_children():
		if child is State:
#			we populate the dictionary with child states
			states[child.name] = child
			child.transitioned.connect(self.on_state_transition)


func _process(delta: float) -> void:
	if current_state:
		current_state.onUpdate(delta)

func on_state_transition(state, new_state_to_set):
#	new_state_to_set is a string (name of new state), current_state is an object
#if we're trying to enter the state we're already in, just return
	if new_state_to_set == current_state.name:
		return
	
#	new_state is an object, we 
#we set the new_state to the child state
	var new_state = states[new_state_to_set]
#	if such child state doesn't exist,return
	if !new_state:
		return
	
#	we set the new state and call its enter function
	current_state = new_state
	current_state.onEnter()

