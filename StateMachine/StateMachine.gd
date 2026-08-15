extends Node

class_name StateMachine

@export var current_state: State = null:
    set(value):
        current_state = value
        if current_state:
            current_state_name = current_state.name
@export var valid_state_transitions: Dictionary[State, Array] = {}
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

func request_state_change(state: String) -> bool:
    var target_state: State = states.get(state.to_lower())
    if target_state == null:
        DebugLogger.error("State {state} not found in states dictionary.".format({state=state}))
        return false
    if current_state == null:
        change_state(state)
        return true
    if valid_state_transitions.has(current_state):
        var allowed_transitions: Array = valid_state_transitions[current_state]
        DebugLogger.trace("{name} allowed transitions from {current}: {allowed}".format({"name": owner.name, "current": current_state.name, "allowed": allowed_transitions}))
        if state in allowed_transitions:
            change_state(state)
            return true
        else:
            DebugLogger.trace("{name} cannot transition from {current} to {target}".format({"name": owner.name, "current": current_state.name, "target": target_state.name}))
            return false
    DebugLogger.trace("{name} has no valid transitions defined for {current}, allowing transition to {target}".format({"name": owner.name, "current": current_state.name, "target": target_state.name}))
    change_state(state)
    return true

func enable() -> void:
    process_mode = Node.PROCESS_MODE_INHERIT

func disable() -> void:
    process_mode = Node.PROCESS_MODE_DISABLED

func update(delta: float) -> void:
    if current_state != null:
        current_state.update(delta, owner)
