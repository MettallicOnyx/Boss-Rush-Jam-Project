extends Node
class_name State

#We're making an array in case that we're choosing a random attack out of 3 possible ones
@export var next_state: Array[State]
#this signal will trigger whenever the condition for changing the state is true
signal transitioned(state, new_state_to_set)

#this gets called whenever the state is entered
func onEnter():
	pass

#in the actual state, we'll call onUpdate inside of physics process and pass it the delta argument
func onUpdate(delta):
	pass

#this gets called whenever the state is exited
#we can call it right before triggering the transitioned signal, or we can call it in FSM before changing the current_state
#I chose the first option
func onExit():
	pass
