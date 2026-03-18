@abstract
class_name ObservationCollectorInterface extends Node

static var instance: ObservationCollectorInterface = null

var observation: Array = []
var action_mask: Dictionary = {}
var reward: float = 0.0

func _ready() -> void:
    if instance:
        push_error("Multiple instances of ObservationCollector detected. This is not supported.")
    else:
        instance = self

func get_observation() -> Dictionary:
    observation = _observation()
    action_mask = _action_mask()
    reward = _reward()
    return {
        "observation": observation,
        "action_mask": action_mask,
        "reward": reward
    }

@abstract func _observation() -> Array
@abstract func _action_mask() -> Dictionary
@abstract func _reward() -> float
