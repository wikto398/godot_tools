extends Node

class_name StateMachine

@export var current_state: State = null
var current_state_name: String = ""
var states: Dictionary[String, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.change_state.connect(change_state)
			child.process_mode = Node.PROCESS_MODE_DISABLED

	if current_state == null:
		current_state = get_child(0)
		current_state.process_mode = Node.PROCESS_MODE_INHERIT
	current_state.enter(owner)

func change_state(state: String) -> void:
	var new_state: State = states.get(state.to_lower())
	if new_state == null:
		DebugLogger.error("State {state} not found in states dictionary.".format({state=state}))
		return

	if current_state != new_state:
		DebugLogger.debug("{name} changing state from {old} to {new}".format({"name": owner.name, "old": current_state.name, "new": new_state.name}))
		states["previous"] = current_state
		current_state.exit(owner)
		current_state.process_mode = Node.PROCESS_MODE_DISABLED
		current_state = new_state
		current_state.process_mode = Node.PROCESS_MODE_INHERIT
		current_state.enter(owner)
		current_state_name = current_state.name

func enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func setup(used_signal = null) -> void:
	if used_signal != null:
		used_signal.connect(_update_on_signal)
	else:
		get_tree().physics_frame.connect(_update_on_physics)

func _update_on_physics(delta: float) -> void:
	current_state.update(delta, owner)

func _update_on_signal() -> void:
	current_state.update(0, owner)
